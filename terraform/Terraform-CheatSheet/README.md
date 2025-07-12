# 📘 Terraform Commands Cheat Sheet

A quick reference of essential Terraform commands for infrastructure management.

---

## 🔧 Initialization

| Command                | Description                                                  |
|------------------------|--------------------------------------------------------------|
| `terraform init`       | Initializes Terraform working directory and downloads providers. |

---

## 🔍 Validation & Formatting

| Command                 | Description                                                   |
|-------------------------|---------------------------------------------------------------|
| `terraform fmt`         | Formats `.tf` files to standard style.                        |
| `terraform validate`    | Validates the configuration for syntax and correctness.       |

---

## 📖 Plan & Show

| Command                     | Description                                                  |
|-----------------------------|--------------------------------------------------------------|
| `terraform plan`            | Shows what changes Terraform will make before applying.      |
| `terraform show`            | Displays the current state or saved plan.                    |
| `terraform state list`      | Lists resources in the current state.                         |
| `terraform state show <resource>` | Shows attributes of a specific resource from state.         |

---

## 🚀 Apply & Destroy

| Command                          | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| `terraform apply`                | Applies infrastructure changes.                              |
| `terraform apply -auto-approve`  | Applies changes without confirmation prompt.                 |
| `terraform destroy`              | Destroys managed infrastructure.                             |

---

## 🔄 Resource Management

| Command                         | Description                                                  |
|---------------------------------|--------------------------------------------------------------|
| `terraform taint <resource>`    | Marks a resource for recreation during the next apply.       |
| `terraform untaint <resource>`  | Removes the taint from a resource.                           |
| `terraform import <address> <id>` | Imports existing infrastructure into Terraform.             |
| `terraform refresh`             | Updates state with real-world resource changes.              |

---

## 📦 Modules

| Command                | Description                                                  |
|------------------------|--------------------------------------------------------------|
| `terraform get`        | Downloads and updates modules used in the config.            |
| `terraform module list`| Lists all modules used in the current configuration.         |

---

## 📁 Workspaces

| Command                          | Description                                                  |
|----------------------------------|--------------------------------------------------------------|
| `terraform workspace list`       | Lists all available workspaces.                             |
| `terraform workspace new <name>` | Creates a new workspace.                                    |
| `terraform workspace select <name>` | Switches to the specified workspace.                    |

---

## 🗂️ State File Operations

| Command                           | Description                                                  |
|-----------------------------------|--------------------------------------------------------------|
| `terraform state mv`              | Moves a resource in the state.                              |
| `terraform state rm <resource>`   | Removes a resource from the state file.                     |

---

## ✅ Tip

For best practices:
- Use `terraform fmt` to keep code clean.
- Run `terraform plan` before `apply` for safe deployments.
- Use workspaces for managing multiple environments like dev/stage/prod.

---