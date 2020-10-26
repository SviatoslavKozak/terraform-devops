provider "github" {
  token = var.token
}
resource "github_repository" "terraform" {
  name        = "terraform"
  description = "My new repository for use with Terraform"
  auto_init   = true
  private     = true
}
resource "github_branch" "develop" {
  depends_on = [github_repository.terraform]
  repository = "terraform"
  branch     = "develop"
}
resource "github_branch_protection" "terraform" {
  repository_id  = github_repository.terraform.node_id
  pattern     = "main"
  enforce_admins = true
}
resource "github_user_ssh_key" "example" {
  title = "svyatoslav"
  key   = file("C:/Users/svyat/.ssh/id_rsa.pub")
}

