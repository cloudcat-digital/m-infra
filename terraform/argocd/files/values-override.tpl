server:
  config:
    repositories: |-
      - name: ${argocd_git_repo_path_name}
        type: git
        url: ${argocd_git_repo_path}
#        sshPrivateKeySecret:
#          key:ssh_key_or_token
#          name: github_secret
  extraArgs:
      - --insecure