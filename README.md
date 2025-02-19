# Git Deploy Helper

A simple and flexible **Git workflow automation tool** for managing deployments.  
Supports **AWS Elastic Beanstalk**, **S3-based deployments**, and **custom workflows**.

---

## Table of Contents
- [Features](#features)
- [Installation & Setup](#installation--setup)
- [Git Workflow](#git-workflow)
  - [Standard Branch Setup](#standard-branch-setup)
  - [Creating a New Feature](#creating-a-new-feature)
  - [Merging `dev` → `test`](#merging-dev--test)
  - [Deploying to `test`](#deploying-to-test)
  - [Deploying to `prod`](#deploying-to-prod)
- [Additional Commands](#additional-commands)
- [AWS Elastic Beanstalk Commands](#aws-elastic-beanstalk-commands)
- [Customization](#customization)
- [Contributing](#contributing)
- [License](#license)
- [Like this project?](#like-this-project)

---

## Features
- Automates **branch merging & PR creation**  
- **Deploys to AWS Elastic Beanstalk** with S3-based ZIP uploads  
- **Paginates recent builds** for easy selection  
- Uses a `.env` file to allow **custom environment settings**  
- Includes **helper functions for AWS Elastic Beanstalk**  

---

## Installation & Setup

### Clone the Repository
```bash
git clone https://github.com/yourusername/git-deploy-helper.git
cd git-deploy-helper
```

### Set Up Environment Variables
- The `.env` file **should be placed in your project directory**, NOT in `git-deploy-helper`.
- Copy `.env.example` to your project folder and rename it to `.env`:
  ```bash
  cp /path/to/git-deploy-helper/.env.example /path/to/your/project/.env
  ```
- Edit `.env` inside your **project folder** and set your **AWS S3 bucket**, **Elastic Beanstalk environments**, and **repo details**.

### Make Scripts Globally Usable
- Open `.bashrc` or `.bash_profile`:
  ```bash
  nano ~/.bashrc
  ```
- Add this line at the bottom so you can run commands globally:
  ```bash
  source /path/to/git-deploy-helper/scripts/common.sh
  ```
- Reload your shell:
  ```bash
  source ~/.bashrc
  ```

---

## Git Workflow

### Standard Branch Setup
| Branch | Purpose |
|--------|---------|
| `dev` | Active development |
| `test` | Staging environment |
| `release` | **Tracks what is actually in production** |
| `main` (prod) | Stable production |

---

### Creating a New Feature
```bash
git checkout dev
git pull
git checkout -b feature/my-new-feature
```
- Work on the feature, then:
  ```bash
  push2pr "My commit message"
  ```
- This commits, pushes, and **provides a PR URL** to merge into `dev`.

---

### Merging `dev` → `test`
- Merge & test new changes:
  ```bash
  dev2test
  ```
- This merges `dev` into `test` and uploads a `.zip` build to **S3**.

---

### Deploying to `test`
- Navigate to your project directory first:
  ```bash
  cd /path/to/your/project
  ```
- Deploy the `test` branch to AWS Elastic Beanstalk:
  ```bash
  deploy2test
  ```
- **Once the testing team is ready to test, start the test environment:**
  ```bash
  ebstart-test
  ```
- To pause the `test` environment when not in use:
  ```bash
  ebpause-test
  ```

---

### Deploying to `prod`
1. Navigate to your project directory:
   ```bash
   cd /path/to/your/project
   ```
2. Run:
   ```bash
   deploy2prod
   ```
3. It **lists recent `.zip` files** in S3 with **date/time**.
4. Select the correct file, and it **deploys to production**.

---

## Additional Commands

### Push Directly to `dev` (Not Recommended)
```bash
push2dev "Your commit message"
```
- **Commits & pushes directly to `dev`** (use `push2pr` instead).

---

## AWS Elastic Beanstalk Commands
- **Start the test environment (when ready for testing):**
  ```bash
  ebstart-test
  ```
- **Pause the test environment (when not in use):**
  ```bash
  ebpause-test
  ```
- These commands work because `eb_test.sh` is sourced automatically via `common.sh`.

---

## Customization
- The `.env` file **must be inside your project directory**.
- Modify the scripts inside `/scripts/` to fit other **deployment strategies** (e.g., Kubernetes, Docker, EC2).

---

## Contributing
Open **issues & pull requests** to improve this tool!  
Feedback is welcome. Fork the repo & make it better!

---

## License
MIT License - Free to use & modify.

---

## Like this project?
⭐ Star the repo on GitHub!  

**Support:** Buy me a [Coffee](https://buymeacoffee.com/roamingsaint) | [Ko-fi](https://ko-fi.com/roamingsaint)
