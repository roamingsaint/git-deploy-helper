# 🧐 Git Deploy Helper

A simple and flexible **Git workflow automation tool** for managing deployments.  
Supports **AWS Elastic Beanstalk**, **S3-based deployments**, and **custom workflows**.

---

## 🚀 Features
✅ Automates **branch merging & PR creation**  
✅ **Deploys to AWS Elastic Beanstalk** with S3-based ZIP uploads  
✅ **Paginates recent builds** for easy selection  
✅ Uses a `.env` file to allow **custom environment settings**  

---

## 📦 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone https://github.com/yourusername/git-deploy-helper.git
cd git-deploy-helper
```

### 2️⃣ Set Up Environment Variables
- Copy `.env.example` and rename it to `.env`:
  ```bash
  cp .env.example .env
  ```
- Edit `.env` and set your **AWS S3 bucket**, **Elastic Beanstalk environments**, and **repo details**.

### 3️⃣ Make Scripts Executable
```bash
chmod +x scripts/*.sh
```

### 4️⃣ Source Scripts in `.bashrc`
- Open `.bashrc` or `.bash_profile`:
  ```bash
  nano ~/.bashrc
  ```
- Add this line at the bottom:
  ```bash
  source /path/to/git-deploy-helper/scripts/common.sh
  ```
- Reload your shell:
  ```bash
  source ~/.bashrc
  ```

---

## 🔄 Git Workflow

### 📌 Standard Branch Setup
| Branch | Purpose |
|--------|---------|
| `dev` | Active development |
| `test` | Staging environment |
| `main` (prod) | Production-ready code |

---

### 🌱 Creating a New Feature
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

### 🔄 Merging `dev` → `test`
- Merge & test new changes:
  ```bash
  dev2test
  ```
- This merges `dev` into `test` and uploads a `.zip` build to **S3**.

---

### 🛠 Deploying to `test`
- If `test` environment is **not running**, start it:
  ```bash
  ebstart-mstest
  ```
- Deploy the `test` branch to AWS Elastic Beanstalk:
  ```bash
  deploy2test
  ```

---

### 🚀 Deploying to `prod`
1. Run:
   ```bash
   deploy2prod
   ```
2. It **lists recent `.zip` files** in S3 with **date/time**.
3. Select the correct file, and it **deploys to production**.

---

## 🛠 Additional Commands

### ⚡ Push Directly to `dev` (Not Recommended)
```bash
push2dev "Your commit message"
```
- **Commits & pushes directly to `dev`** (use `push2pr` instead).

---

## 🛠 Customization
- The `.env` file allows you to **customize** all AWS details.
- Modify the scripts inside `/scripts/` to fit other **deployment strategies** (e.g., Kubernetes, Docker, EC2).

---

## 👥 Contributing
🎯 Open **issues & pull requests** to improve this tool!  
💬 Feedback is welcome. Fork the repo & make it better!

---

## 📝 License
MIT License - Free to use & modify.

---

## ⭐ Like this project?
Star the repo on GitHub! 🚀  

**Support:** Buy me a [Coffee](https://buymeacoffee.com/roamingsaint) | [Ko-fi](https://ko-fi.com/roamingsaint)
