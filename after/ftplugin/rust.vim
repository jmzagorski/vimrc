if filereadable(getcwd() . "/lint.sh")
  let b:ale_rust_cargo_use_global = 1
  let b:ale_rust_rls_use_global = 1
  " This is the path to the script above.
  let b:ale_rust_cargo_executable = getcwd() . "/lint.sh"
  let b:ale_rust_rls_executable = getcwd() . "/lint.sh"
  " /data matches the path in Docker.
  let b:ale_filename_mappings = {
  \ 'cargo': [
  \   [getcwd(), '/app'],
  \ ],
  \ 'rls': [
  \   [getcwd(), '/app'],
  \ ],
  \}
endif
