# provider defined in providers.tf file

provider "github" {
  token = ""
}

resource "github_repository" "github-repo" {
  name = "created-by-terrafrom"
}