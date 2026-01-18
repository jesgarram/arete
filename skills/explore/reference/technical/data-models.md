# Data Models & Encoding

## Key Concepts

Data modeling determines how information is structured - relational (tables, joins), document (nested JSON), or graph (nodes, edges). Encoding affects storage efficiency and schema evolution - JSON is flexible but verbose, Protocol Buffers are compact but require schema definition. Schema evolution strategy determines whether you can change your data model without breaking existing clients.

## Questions

- Is your data relational (lots of joins) or hierarchical (nested documents)?
- Do you need schema flexibility or strict validation? Who benefits from each?
- How often does the schema change? Weekly, monthly, yearly?
- Who are the API consumers? Internal services that you control or external clients?
- Do you need backward compatibility (new code reads old data) or forward compatibility (old code reads new data)?
- What's the data access pattern? Fetch entire entities or just specific fields?
- Do you have many-to-many relationships or mostly one-to-many?
- Is the data structure stable or still evolving rapidly?
- Do you need to support multiple API versions simultaneously?
- What happens when you add a new field? Do all consumers need to update?
- Are there natural aggregates or bounded contexts in your domain?
- Do you need referential integrity or can you tolerate eventual consistency?
