---
title: "Quick Start"
weight: 5
description: "Get your first AI agent running in minutes using LangGraph and MCP integration."
---

Get your AI agent up and running quickly! This guide walks you through cloning the template, configuring MCP servers, and deploying your first agent.

## Prerequisites

Before you begin, ensure you have:

- **Python 3.12+** installed
- **UV package manager** ([installation guide](https://docs.astral.sh/uv/getting-started/installation/))
- **At least one MCP server** running (see [MCP Server Template](/templates/mcp-server/))
- **Basic understanding** of Python and async programming

## Step 1: Clone the Template

```bash
# Clone the agent template
git clone https://github.com/redhat-data-and-ai/template-agent.git
cd template-agent

# Set up Python environment
uv venv --python 3.12
source .venv/bin/activate

# Install dependencies
uv pip install -e ".[dev]"
```

## Step 2: Configure MCP Servers

Edit the configuration file to point to your MCP servers:

```python
# config/settings.py or .env file
MCP_SERVERS=[
    "http://localhost:3000/mcp",  # Your MCP server
]

# LLM Configuration
LLM_MODEL="gpt-4"
LLM_API_KEY="your-api-key"
```

{{< info >}}
**MCP Servers Required**: The agent needs at least one MCP server to provide tools and capabilities. If you don't have one yet, start with the [MCP Server Quick Start](/templates/mcp-server/quick-start/).
{{< /info >}}

## Step 3: Run Your First Agent

```bash
# Start the agent
python -m agent_template.src.main

# The agent will:
# 1. Connect to your MCP servers
# 2. Discover available tools
# 3. Start accepting requests
```

## Step 4: Test the Agent

Send a test request to verify everything works:

```python
# test_agent.py
import asyncio
from agent_template.src.agent import run_agent

async def test():
    result = await run_agent("Hello! What tools do you have available?")
    print(result)

asyncio.run(test())
```

## Step 5: Customize for Your Use Case

Now that the basic agent is working, customize it:

1. **Define your workflow** - Edit `src/agent/workflows.py`
2. **Add custom prompts** - Update `src/agent/prompts.py`
3. **Configure tools** - Adjust which MCP tools to use
4. **Test thoroughly** - Run `pytest` to verify

## Next Steps

- **Deploy to production**: Follow the Kubernetes deployment guides in the repository
- **Add more MCP servers**: Connect to additional MCP servers for more capabilities
- **Build a UI**: Add the [UI Template](/templates/ui/) for a chat interface
- **Join the community**: [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions)

{{< tip >}}
**Pro Tip**: Start with simple, single-step agent workflows and gradually add complexity. Test each addition before moving to the next feature.
{{< /tip >}}

## Troubleshooting

**Agent won't start**
- Check that MCP server URLs are correct and accessible
- Verify your LLM API key is valid
- Review logs for connection errors

**Tools not working**
- Ensure MCP servers are running (`curl http://localhost:3000/health`)
- Verify tool permissions and authentication
- Check MCP server logs for errors

For more help, visit [GitHub Issues](https://github.com/redhat-data-and-ai/template-agent/issues).

