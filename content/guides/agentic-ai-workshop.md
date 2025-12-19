---
title: "Zero to Production: Agentic AI Workshop"
weight: 10
description: "Build a complete, professional-grade AI application using three modular open-source templates."
---

Welcome to the **Agentic AI Workshop**. In this guide, you will learn how to build a complete, professional-grade AI application using three modular open-source templates.

This isn't just a small demo; we are building the real, scalable "plumbing" that powers enterprise-level AI. Whether you are a solo developer or preparing for a hackathon, these templates provide the production-ready foundation you need.

## The Architecture: A High-Tech Restaurant

To understand how these three pieces fit together, imagine a high-tech restaurant:

- **The UI Application (The Waiter):** The friendly face that greets the user, takes their chat message (order), and brings back the AI's response (food).
- **The Agent (The Chef):** The brain in the kitchen that decides what to do. When an order is complex, the chef delegates specialized tasks to helpers.
- **The MCP Server (The Sous Chefs):** A team of specialized assistants, each an expert in their craft—one fetches ingredients from the pantry, another is a master sauce maker, another handles all the chopping and prep. The chef simply calls on whichever specialist is needed without worrying about the details.

---

## Prerequisites

Before we start "cooking," ensure your environment is ready:

- **Code Editor:** [Cursor AI](https://www.cursor.com/) (recommended)
- **AI Brain:** A Google Gemini API Key
- **Runtime Tools:**
  - [uv](https://astral.sh/uv) for Python package management
  - [Node.js](https://nodejs.org/) (v22+)
  - [GNU Make](https://www.gnu.org/software/make/)
  - [Podman](https://podman.io/) or Docker for running local databases

---

## Building the Agentic Application

Now let's build the three components of our agentic AI application. Each template can be cloned, configured, and run locally in minutes.

### 1. The MCP Server (The Sous Chefs)

The MCP Server is a FastAPI-based microservice that keeps your business logic (tools) separate from your AI logic.

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

#### Adding a Custom Tool

Create a new file at `src/tools/my_tool.py` and add a function with a **docstring**. The AI agent reads this docstring to understand when to use the tool.

```python
def get_sales_data(territory: str, quarter: str):
    """Retrieve sales data for a specific territory and quarter."""
    return {"territory": territory, "sales": 10000}
```

---

### 2. The Template Agent (The Brain)

Built with **LangGraph**, this agent handles stateful conversations, meaning it remembers what was said previously.

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

## Moving to Production

When you're ready to move beyond your local machine (e.g., for a hackathon submission or enterprise deployment), consider these best practices:

- **Security:** Enable OAuth2/SSO and configure SSL/TLS certificates.
- **Scalability:** Deploy to Kubernetes or OpenShift for container orchestration, auto-scaling, and high availability. Use a managed PostgreSQL service instead of a local container.
- **Observability:** Set up [Langfuse](https://langfuse.com/) to trace and debug your agent's thought process.

Each template includes Kubernetes manifests and Helm charts to simplify deployment to production clusters.

---

## Next Steps

Ready to dive deeper? Check out:

- [MCP Server Template Documentation](/templates/mcp-server/)
- [Agent Template Documentation](/templates/agent/)
- [UI Template Documentation](/templates/ui/)

For questions or feedback, visit [GitHub Discussions](https://github.com/redhat-data-and-ai/website/discussions).
