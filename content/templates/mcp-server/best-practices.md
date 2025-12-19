---
title: "Development Best Practices"
weight: 30
description: "Comprehensive best practices for developing AI agents and MCP servers, covering code quality, security, performance, and maintainability."
---

This guide provides comprehensive best practices for developing production-ready AI agents and MCP servers. Whether you're building conversational agents or custom MCP servers, following these practices will help you create maintainable, secure, and high-performing solutions.

## Development Areas

- **[Agent Development Best Practices](#agent-development-best-practices)** - LangGraph workflows and MCP client integration
- **[MCP Server Development Best Practices](#mcp-server-development-best-practices)** - Framework-agnostic patterns

---

## Agent Development Best Practices

### 1. Code Organization & Structure

#### Project Structure

```text
ask-agent/
├── ask_agent/
│   └── src/
│       ├── __init__.py
│       ├── main.py             # Main agent entry point
│       ├── agent/
│       │   ├── __init__.py
│       │   ├── workflows.py    # LangGraph workflows
│       │   ├── tools.py       # Tool integrations
│       │   └── prompts.py     # Prompt templates
│       ├── config/
│       │   ├── __init__.py
│       │   └── settings.py    # Configuration management
│       └── utils/
│           ├── __init__.py
│           ├── mcp_client.py  # MCP client utilities
│           └── formatting.py # Response formatting
├── tests/                      # Comprehensive test suite
├── examples/                   # Usage examples
├── pyproject.toml             # Modern Python project configuration
├── .env.template              # Environment variables template
├── Containerfile              # Container build instructions
└── README.md
```

{{< tip >}}
**Nested Structure**: Like MCP servers, agents benefit from nested package structure (`ask_agent/src/`) for container isolation and deployment benefits.
{{< /tip >}}

#### Configuration Management

```python
# config/settings.py
from pydantic_settings import BaseSettings
from typing import List

class AgentSettings(BaseSettings):
    """Agent configuration with validation."""

    # MCP Server Endpoints
    MCP_SERVERS: List[str] = [
        "http://localhost:8001",
        "http://localhost:8002",
    ]

    # LLM Configuration
    LLM_MODEL: str = "gpt-4"
    LLM_TEMPERATURE: float = 0.7
    MAX_TOKENS: int = 4000

    # Agent Configuration
    AGENT_NAME: str = "AI Agent"
    MAX_ITERATIONS: int = 10
    TIMEOUT_SECONDS: int = 30

    # Logging
    LOG_LEVEL: str = "INFO"

    class Config:
        env_file = ".env"
        case_sensitive = False
```

### 2. LangGraph Workflow Design

#### State Management

```python
# agent/workflows.py
from typing import TypedDict, List, Optional
from langgraph import StateGraph, START, END

class AgentState(TypedDict):
    """Agent state with proper typing."""
    messages: List[dict]
    current_task: Optional[str]
    tools_used: List[str]
    iterations: int
    context: dict
    final_answer: Optional[str]

def create_agent_workflow() -> StateGraph:
    """Create a well-structured agent workflow."""
    workflow = StateGraph(AgentState)

    # Add nodes with clear responsibilities
    workflow.add_node("planner", plan_task)
    workflow.add_node("executor", execute_task)
    workflow.add_node("validator", validate_result)
    workflow.add_node("formatter", format_response)

    # Define clear flow with conditional logic
    workflow.add_edge(START, "planner")
    workflow.add_conditional_edges(
        "planner",
        should_execute,
        {"execute": "executor", "end": "formatter"}
    )
    
    return workflow.compile()
```

### 3. Testing & Quality Assurance

```python
# tests/test_workflows.py
import pytest
from agent.workflows import create_agent_workflow, AgentState

@pytest.fixture
def sample_state():
    return AgentState(
        messages=[{"role": "user", "content": "Analyze data"}],
        current_task=None,
        tools_used=[],
        iterations=0,
        context={},
        final_answer=None
    )

@pytest.mark.asyncio
async def test_workflow_execution(sample_state):
    """Test complete workflow execution."""
    workflow = create_agent_workflow()
    result = await workflow.ainvoke(sample_state)
    
    assert result["final_answer"] is not None
    assert result["iterations"] > 0
```

---

## MCP Server Development Best Practices

{{< info >}}
**Architecture First**: For comprehensive guidance on MCP server architecture decisions (FastAPI vs FastMCP, nested package structure, async patterns), see the Enterprise MCP Template documentation.
{{< /info >}}

### 1. Configuration Management

```python
from pydantic_settings import BaseSettings
from typing import Optional

class ServerSettings(BaseSettings):
    """Type-safe server configuration."""

    # External service configuration
    EXTERNAL_API_URL: str
    EXTERNAL_API_KEY: str

    # Server configuration
    HOST: str = "localhost"
    PORT: int = 8001
    LOG_LEVEL: str = "INFO"

    # Performance settings
    MAX_CONNECTIONS: int = 100
    TIMEOUT_SECONDS: int = 30

    # SSL Configuration
    SSL_KEYFILE: Optional[str] = None
    SSL_CERTFILE: Optional[str] = None

    class Config:
        env_file = ".env"
        case_sensitive = False
```

### 2. Input Validation & Security

```python
# utils/validation.py
import re
from pydantic import BaseModel, validator

class QueryValidator(BaseModel):
    """Validate SQL queries for security."""

    query: str
    max_length: int = 10000

    @validator('query')
    def validate_query_safety(cls, v):
        if not v.strip():
            raise ValueError("Query cannot be empty")

        # Check for dangerous patterns
        dangerous_patterns = [
            r'\b(DELETE|DROP|TRUNCATE|ALTER)\b',
            r'\b(EXEC|EXECUTE)\b',
            r'\b(UNION.*SELECT)\b',
        ]

        for pattern in dangerous_patterns:
            if re.search(pattern, v, re.IGNORECASE):
                raise ValueError(f"Query contains dangerous pattern")

        return v
```

### 3. Error Handling & Resilience

```python
# utils/resilience.py
from enum import Enum
import time

class CircuitState(Enum):
    CLOSED = "closed"
    OPEN = "open"
    HALF_OPEN = "half_open"

class CircuitBreaker:
    """Circuit breaker pattern for external services."""

    def __init__(self, failure_threshold: int = 5, timeout: int = 60):
        self.failure_threshold = failure_threshold
        self.timeout = timeout
        self.failure_count = 0
        self.last_failure_time = None
        self.state = CircuitState.CLOSED

    async def call(self, func, *args, **kwargs):
        """Execute function with circuit breaker protection."""
        if self.state == CircuitState.OPEN:
            if time.time() - self.last_failure_time > self.timeout:
                self.state = CircuitState.HALF_OPEN
            else:
                raise Exception("Circuit breaker is OPEN")

        try:
            result = await func(*args, **kwargs)
            self._on_success()
            return result
        except Exception as e:
            self._on_failure()
            raise

    def _on_success(self):
        self.failure_count = 0
        self.state = CircuitState.CLOSED

    def _on_failure(self):
        self.failure_count += 1
        self.last_failure_time = time.time()
        if self.failure_count >= self.failure_threshold:
            self.state = CircuitState.OPEN
```

### 4. Performance Optimization

```python
# utils/caching.py
import hashlib
import json
from typing import Any, Optional, Dict

class CacheManager:
    """Async cache with TTL support."""

    def __init__(self, default_ttl: int = 300):
        self.cache: Dict[str, Dict[str, Any]] = {}
        self.default_ttl = default_ttl

    def cache_key(self, func_name: str, args: tuple, kwargs: dict) -> str:
        """Generate cache key from function and arguments."""
        key_data = {"func": func_name, "args": args, "kwargs": kwargs}
        key_str = json.dumps(key_data, sort_keys=True)
        return hashlib.md5(key_str.encode()).hexdigest()

    async def get(self, key: str) -> Optional[Any]:
        """Get value from cache."""
        if key in self.cache:
            entry = self.cache[key]
            if time.time() < entry["expires_at"]:
                return entry["value"]
            else:
                del self.cache[key]
        return None
```

### 5. Comprehensive Testing

```python
# tests/test_integration.py
import pytest
from unittest.mock import patch

@pytest.mark.asyncio
async def test_tool_integration(test_client):
    """Test tool integration with external services."""
    response = await test_client.post("/tools/query_data", json={
        "query": "SELECT * FROM test_table",
        "limit": 10
    })

    assert response.status_code == 200
    result = response.json()
    assert result["status"] == "success"
```

## Common Anti-Patterns to Avoid

### Agent Development

- **Hardcoded MCP server addresses** - Use configuration management
- **Lack of error handling** - Always implement comprehensive error handling
- **Infinite loops in workflows** - Set iteration limits and timeouts
- **Synchronous MCP calls** - Use async/await patterns
- **Poor state management** - Use proper TypedDict for state

### MCP Server Development

- **No input validation** - Always validate and sanitize inputs
- **Missing connection pooling** - Use connection pools for external services
- **No caching strategy** - Cache expensive operations
- **Lack of observability** - Implement comprehensive logging and monitoring
- **No circuit breakers** - Protect against cascading failures

## Resources

### Documentation

- **[Quick Start](quick-start)** - Hands-on implementation guide
- **[Taking to Production](taking-mcp-server-to-production)** - Deployment lifecycle

### External Resources

- **[LangGraph Documentation](https://langchain-ai.github.io/langgraph/)** - Advanced agent workflows
- **[FastAPI Documentation](https://fastapi.tiangolo.com/)** - Enterprise web framework
- **[Pydantic Settings](https://docs.pydantic.dev/usage/settings/)** - Configuration management

For questions and community support, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).

