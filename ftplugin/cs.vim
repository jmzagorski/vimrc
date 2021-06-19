let b:ale_linters = ['omnisharp']
let b:ale_cs_omnisharp_use_global = 1
  " This is the path to the script above.
let b:ale_cs_omnisharp_executable = '/home/jmzagorski/projects/business-forms/business-forms-webapi/src/docker-lint.sh'
" /data matches the path in Docker.
let b:ale_filename_mappings = {
\ 'omnisharp': [
\   ['/home/jmzagorski/projects/business-forms/business-forms-webapi/src/', '/webapi'],
\ ],
\}
