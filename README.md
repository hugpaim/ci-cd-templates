# 🔄 ci-cd-templates

> Reusable CI/CD pipeline templates for GitHub Actions and Jenkins — covering build, test, lint, security scan and Docker deployment workflows.

![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?style=flat-square&logo=github-actions&logoColor=white)
![Jenkins](https://img.shields.io/badge/Jenkins-D24939?style=flat-square&logo=jenkins&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=flat-square&logo=docker&logoColor=white)
![CI](https://github.com/hugpaim/ci-cd-templates/actions/workflows/python-ci.yml/badge.svg)

---

## 📁 Structure

```
ci-cd-templates/
├── .github/workflows/
│   ├── docker-build-push.yml    # Build & push image to GHCR
│   ├── python-ci.yml            # Python lint + test + coverage
│   ├── terraform-plan.yml       # Terraform validate + plan on PR
│   └── security-scan.yml        # Trivy image + repo vulnerability scan
├── jenkins/
│   ├── Jenkinsfile.docker        # Docker build + push pipeline
│   └── Jenkinsfile.python        # Python CI pipeline
└── scripts/
    └── tag-release.sh            # Semantic version tagging helper
```

## 🚀 Usage

### GitHub Actions
Copy any workflow file into your repo's `.github/workflows/` directory:
```bash
cp .github/workflows/docker-build-push.yml your-repo/.github/workflows/
```

### Jenkins
Copy the relevant `Jenkinsfile` to your repo root and configure the pipeline in Jenkins to use it.

## 📋 Templates

| Template | Trigger | Steps |
|----------|---------|-------|
| `docker-build-push.yml` | push to main / PR | build → push GHCR → sign |
| `python-ci.yml` | push / PR | lint → test → coverage report |
| `terraform-plan.yml` | PR | init → validate → fmt check → plan |
| `security-scan.yml` | push / schedule | Trivy FS scan → Trivy image scan |
| `Jenkinsfile.docker` | SCM poll | checkout → build → push → deploy |
| `Jenkinsfile.python` | SCM poll | install → lint → test → archive |

---

> Part of [@hugpaim](https://github.com/hugpaim) DevOps portfolio
