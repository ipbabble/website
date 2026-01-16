---
title: "Zero to Production: Agentic AI Onboarding"
weight: 10
description: "Build a complete, professional-grade AI application using three modular open-source templates."
---

Welcome to the **Agentic AI Onboarding**. In this guide, you will learn how to build a complete, professional-grade AI application using three modular open-source templates.

This isn't just a small demo; we are building the real, scalable "plumbing" that powers enterprise-level AI. Whether you are a solo developer or preparing for a hackathon, these templates provide the production-ready foundation you need.

## The Architecture: A High-Tech Restaurant

To understand how these three pieces fit together, imagine a high-tech restaurant:

- **The UI Application (The Waiter):** The friendly face that greets the user, takes their chat message (order), and brings back the AI's response (food).
- **The Agent (The Chef):** The brain in the kitchen that decides what to do. When an order is complex, the chef delegates specialized tasks to helpers.
- **The MCP Server (The Sous Chefs):** A team of specialized assistants, each an expert in their craft—one fetches ingredients from the pantry, another is a master sauce maker, another handles all the chopping and prep. The chef simply calls on whichever specialist is needed without worrying about the details.

---

## How This Onboarding Works

This onboarding assumes you're using an **AI code assistant** (such as Cursor, Claude Code, or GitHub Copilot) to help you build. When you encounter missing tools or dependencies, your AI assistant will detect the issue and guide you through installation automatically.

{{< tip >}}
**AI-Assisted Development**: Your code assistant handles installing tools like `uv`, `node`, `make`, and `podman` as needed. Just follow along—when something's missing, ask your AI assistant to help install it.

**Windows Users**: The templates work on Windows. Your AI assistant will provide Windows-specific commands (PowerShell for `uv`, Chocolatey/Scoop for `make`). See the [Complete Prerequisites Reference](#complete-prerequisites-reference) for platform-specific details.
{{< /tip >}}

## What You Need (Human Dependencies)

These are things only you can provide—your AI assistant can't create accounts or generate API keys for you:

| Requirement | Why You Need It | Where to Get It |
|-------------|-----------------|-----------------|
| **LLM API Key** | Powers the AI agent's reasoning | [Google AI Studio](https://aistudio.google.com/) (Gemini) or [OpenAI](https://platform.openai.com/) |
| **AI Code Assistant** | Helps you build and debug | [Cursor](https://cursor.com/), [Claude Code](https://claude.ai/), or similar |
| **GitHub Account** | Clone the template repositories | [github.com](https://github.com/) |

{{< info >}}
**API Keys**: Store your API keys securely. Each template includes a `.env.example` file showing what's needed. Copy it to `.env` and add your keys there.
{{< /info >}}

---

## Building the Agentic Application

Now let's build the three components of our agentic AI application. Each template can be cloned, configured, and run locally in minutes.

### How the Components Connect

The three templates communicate via HTTP APIs:

- **MCP Server** runs on `http://localhost:5001` - Provides tools the agent can call
- **Agent** runs on `http://localhost:5002` - Connects to MCP Server, orchestrates reasoning
- **UI** runs on `http://localhost:5173` - Frontend connects to Agent's streaming endpoint

```
[Browser] ←→ [UI:5173] ←→ [Agent:5002] ←→ [MCP Server:5001] ←→ [External APIs/DBs]
```

**Configuration:** The Agent's `.env` file specifies where to find the MCP Server:

```bash
MCP_SERVER_URL=http://localhost:5001
```

The UI's backend automatically connects to the Agent at `http://localhost:5002`. When you type a message in the chat, it flows through this chain: UI → Agent → (if needed) MCP Server → back through Agent → streamed to UI.

### 1. The MCP Server (The Sous Chefs)

The MCP Server is a FastAPI-based microservice that keeps your business logic (tools) separate from your AI logic.

For the most up-to-date setup steps, please visit the [MCP Server Template repository](https://github.com/redhat-data-and-ai/template-mcp-server) and follow the instructions in the README.

#### Quick Start

1. **Clone and Enter:**

```bash
git clone https://github.com/redhat-data-and-ai/template-mcp-server.git
cd template-mcp-server
```

2. **Launch:**

```bash
make local
```

3. **Verify:** Run `curl http://localhost:5001/health`

---

### 2. The Template Agent (The Brain)

Built with **LangGraph**, this agent handles stateful conversations, meaning it remembers what was said previously.

For the most up-to-date setup steps, please visit the [Agent Template repository](https://github.com/redhat-data-and-ai/template-agent) and follow the instructions in the README.

#### Quick Start

1. **Clone and Enter:**

```bash
git clone https://github.com/redhat-data-and-ai/template-agent.git
cd template-agent
```

2. **Configure:** Copy `.env.example` to `.env` and add your Gemini API Key.

3. **Launch:**

```bash
make local
```

4. **Test Streaming:**

```bash
curl -X POST "http://localhost:5002/v1/stream" \
  -H "Content-Type: application/json" \
  -d '{"message": "What is 25 times 42?", "thread_id": "test_1"}'
```

---

### 3. The Template UI (The Face)

A modern **React + Fastify** interface that supports real-time streaming word-by-word responses.

For the most up-to-date setup steps, please visit the [UI Template repository](https://github.com/redhat-data-and-ai/template-ui) and follow the instructions in the README.

#### Quick Start

1. **Clone and Enter:**

```bash
git clone https://github.com/redhat-data-and-ai/template-ui.git
cd template-ui
```

2. **Launch:**

```bash
make install
make local
```

3. **Open:** Visit `http://localhost:5173/` in your browser.

---

## Testing the Complete System

Now that all three components are running, let's verify they work together as an integrated application.

### Verify the Full Flow

1. **Open the UI:** Navigate to `http://localhost:5173/` in your browser
2. **Start a conversation:** Type "What tools do you have available?" in the chat
3. **Watch it work:** You should see:
   - The message streaming back word-by-word
   - The agent listing tools from the MCP Server
   - Smooth, real-time responses

{{< info >}}
**What Success Looks Like:** The chat interface displays streaming responses in real-time. The agent can discover and call tools from the MCP Server, and results appear instantly in the UI.
{{< /info >}}

### Try These Test Queries

- **"What is 25 times 42?"** - Tests basic agent reasoning
- **"What tools can you use?"** - Verifies MCP Server connection
- **"Tell me about yourself"** - Checks agent's system prompt and personality
- **Start a multi-turn conversation** - Verifies stateful memory (the agent remembers context)

### Troubleshooting

{{< warning >}}
**UI shows "Connection error"**

Check that the Agent is running:
```bash
curl http://localhost:5002/health
```

If it's not running, go back to the Agent directory and run `make local`.
{{< /warning >}}

{{< warning >}}
**Agent can't find MCP tools**

Verify the `MCP_SERVER_URL` in your Agent's `.env` file:
```bash
cat .env | grep MCP_SERVER_URL
```

Should show: `MCP_SERVER_URL=http://localhost:5001`
{{< /warning >}}

{{< warning >}}
**Make commands fail on Windows**

Install `make` via package manager:
```powershell
choco install make
# or
scoop install make
```

Alternatively, look inside the `Makefile` and run the commands manually.
{{< /warning >}}

---

## From Onboarding to Real Application

You've got all three components running—congratulations! Now comes the exciting part: transforming these generic templates into a solution that solves **your** business problem.

### Rename and Repurpose Each Template

The templates are designed to be **starting points**, not final products. Here's how to make them yours:

#### MCP Server: Add Your Domain Tools

**What to customize:**
- Rename the project to reflect your data source (e.g., `mcp-server-salesforce`, `mcp-server-postgres`, `mcp-server-jira`)
- Replace the example tools with real integrations to your databases, APIs, or internal systems

**Real-world examples:**
- **Salesforce Integration:** Create tools that query accounts, opportunities, and leads. Your agent can answer "Show me all deals closing this quarter over $100K"
- **PostgreSQL Analytics:** Build tools that run custom SQL queries against your analytics database
- **Stripe/Payment APIs:** Add tools to fetch customer subscriptions, invoices, and payment history
- **Internal HR System:** Connect to your company's employee directory, PTO system, or performance data

**Where to make changes:**
- `src/tools/` - Create new tool files with your functions
- `src/mcp.py` - Register your tools so the agent can discover them
- `pyproject.toml` - Add API client libraries (e.g., `salesforce-bulk`, `psycopg2`, `stripe`)
- `.env` - Add your API keys and connection strings

**Step-by-step: Adding a custom tool**

Let's walk through adding a sales data tool as an example:

**1. Create a new tool** in `src/tools/my_tool.py`:

```python
def get_sales_data(territory: str, quarter: str):
    """Retrieve sales data for a specific territory and quarter.
    
    Args:
        territory: Sales territory (e.g., 'West', 'East', 'Central')
        quarter: Quarter to query (e.g., 'Q1', 'Q2', 'Q3', 'Q4')
    
    Returns:
        Dictionary with territory, quarter, and sales amount
    """
    # In production, this would query your database or CRM
    return {
        "territory": territory,
        "quarter": quarter,
        "sales": 125000,
        "currency": "USD"
    }
```

**2. Register the tool** in `src/mcp.py`:

```python
# Add the import at the top
from template_mcp_server.src.tools.my_tool import get_sales_data

# In the _register_mcp_tools method, add your tool:
def _register_mcp_tools(self) -> None:
    """Register all MCP tools."""
    self.mcp.tool()(multiply_numbers)
    self.mcp.tool()(generate_code_review_prompt)
    self.mcp.tool()(get_logo)
    self.mcp.tool()(get_sales_data)  # Add your new tool here
```

**3. Restart the MCP Server:**

```bash
# Stop the running server (Ctrl+C) and restart
make local
```

**4. Test it through the agent:**

Open the UI at `http://localhost:5173/` and ask:

> "What were sales in the West territory for Q1?"

The agent will automatically discover your `get_sales_data` tool, understand when to use it from the docstring, and call it with the correct parameters!

{{< tip >}}
**The Magic of Docstrings:** The agent reads your function's docstring to understand what the tool does and when to use it. Write clear, descriptive docstrings with `Args:` and `Returns:` sections, and the agent will know exactly when to call your tool. This is how you "teach" the agent about new capabilities.
{{< /tip >}}

#### Agent: Customize the Intelligence

**What to customize:**
- Rename to reflect the agent's purpose (e.g., `agent-sales-assistant`, `agent-customer-support`, `agent-data-analyst`)
- Update the system prompt to define the agent's role, personality, and expertise
- Configure which MCP tools the agent should use

**Real-world examples:**
- **Sales Assistant:** "You are a sales intelligence assistant. Help reps prioritize leads, analyze deal health, and suggest next actions based on CRM data."
- **Customer Support:** "You are a support engineer. Diagnose technical issues by querying logs, checking account status, and suggesting solutions from the knowledge base."
- **Data Analyst:** "You are a business analyst. Answer questions about company metrics by querying databases and generating insights."

**Where to make changes:**
- `src/agent/prompts.py` - Define the system prompt and agent behavior
- `src/agent/config.py` - Configure which MCP servers to connect to
- `src/agent/graph.py` - Customize the agent's workflow (add approval steps, human-in-the-loop, etc.)

#### UI: Brand and Tailor the Experience

**What to customize:**
- Rename to reflect the application (e.g., `ui-sales-copilot`, `ui-support-portal`, `ui-analytics-chat`)
- Update branding, colors, and logos
- Add domain-specific UI elements (charts, tables, quick actions)

**Real-world examples:**
- **Sales Dashboard:** Show key metrics (pipeline value, close rate) alongside the chat interface
- **Support Portal:** Add quick action buttons like "Check Account Status" or "View Recent Tickets"
- **Analytics App:** Include visualization widgets that render when the agent returns data

**Where to make changes:**
- `frontend/src/App.tsx` - Update branding and page title
- `frontend/src/components/Chat.tsx` - Customize the chat interface
- `frontend/src/styles/` - Update colors, fonts, and theme
- `backend/src/api.py` - Add custom endpoints for domain-specific features

### Building Your First Real Prototype

**Step 1: Pick a real problem** - Choose something small but valuable. "Help sales reps find their top 5 hottest deals" beats "Build an entire CRM replacement."

**Step 2: Start with the MCP Server** - Get real data flowing first. Even read-only access to one system is enough to start.

**Step 3: Refine the Agent** - Adjust the prompt until the agent "sounds right" for your use case. Your AI code assistant can help iterate quickly.

**Step 4: Polish the UI** - Add just enough branding and domain context to make it feel real.

**Step 5: Get feedback** - Show it to a colleague, run it in a demo, or use it yourself for a day. Real usage reveals what needs work.

{{< tip >}}
**Vibe Programming Tip:** Don't overthink it. Start changing one template at a time. When you hit an error or need to add a feature, ask your AI code assistant. The templates are designed to be modified—that's the whole point!
{{< /tip >}}

---

## Moving to Production

When you're ready to move beyond your local machine (e.g., for a hackathon submission or enterprise deployment), consider these best practices:

- **Security:** Enable OAuth2/SSO and configure SSL/TLS certificates.
- **Scalability:** Deploy to Kubernetes or OpenShift for container orchestration, auto-scaling, and high availability. Use a managed PostgreSQL service instead of a local container.
- **Observability:** Set up [Langfuse](https://langfuse.com/) to trace and debug your agent's thought process.

Each template includes Kubernetes manifests and Helm charts to simplify deployment to production clusters.

---

## Complete Prerequisites Reference

For developers who prefer to install all dependencies upfront, here's the complete list organized by component:

### MCP Server Template

| Tool | Version | Installation |
|------|---------|--------------|
| Python | 3.12+ | [python.org](https://www.python.org/) (all platforms) |
| uv | Latest | macOS/Linux: `curl -LsSf https://astral.sh/uv/install.sh \| sh`<br>Windows: `powershell -c "irm https://astral.sh/uv/install.ps1 \| iex"` |
| Make | Any | macOS/Linux: Pre-installed<br>Windows: `choco install make` or `scoop install make` |

### Agent Template

| Tool | Version | Installation |
|------|---------|--------------|
| Python | 3.12+ | [python.org](https://www.python.org/) (all platforms) |
| uv | Latest | macOS/Linux: `curl -LsSf https://astral.sh/uv/install.sh \| sh`<br>Windows: `powershell -c "irm https://astral.sh/uv/install.ps1 \| iex"` |
| Make | Any | macOS/Linux: Pre-installed<br>Windows: `choco install make` or `scoop install make` |
| Podman | Latest | [Podman Desktop](https://podman-desktop.io/) (GUI for all platforms)<br>CLI: `brew install podman` (macOS) or `choco install podman-desktop` (Windows) |

### UI Template

| Tool | Version | Installation |
|------|---------|--------------|
| Node.js | 22+ | [nodejs.org](https://nodejs.org/) (all platforms) |
| Python | 3.12+ | [python.org](https://www.python.org/) (all platforms) |
| uv | Latest | macOS/Linux: `curl -LsSf https://astral.sh/uv/install.sh \| sh`<br>Windows: `powershell -c "irm https://astral.sh/uv/install.ps1 \| iex"` |
| Make | Any | macOS/Linux: Pre-installed<br>Windows: `choco install make` or `scoop install make` |

{{< info >}}
**Don't worry about memorizing this.** Your AI code assistant will prompt you to install anything missing when you run the templates. This reference is here for those who prefer upfront setup or are working in restricted environments.
{{< /info >}}

---

## Next Steps

Ready to dive deeper? Check out:

- [MCP Server Template Documentation](/templates/mcp-server/)
- [Agent Template Documentation](/templates/agent/)
- [UI Template Documentation](/templates/ui/)

For questions or feedback, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).
