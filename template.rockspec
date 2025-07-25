local git_ref = '$git_ref'
local modrev = '$modrev'
local specrev = '$specrev'

local repo_url = '$repo_url'

rockspec_format = '3.0'
package = '$package'
version = modrev ..'-'.. specrev

description = {
  summary = '$summary',
  detailed = $detailed_description,
  labels = $labels,
  homepage = '$homepage',
  $license
}

dependencies = {
    "lua >= 5.1",
    "ansicolors",
    "argparse",
    "luafilesystem",
    "luaprompt"
}

test_dependencies = $test_dependencies

source = {
  url = repo_url .. '/archive/' .. git_ref .. '.zip',
  dir = '$repo_name-' .. '$archive_dir_suffix',
}

if modrev == 'scm' or modrev == 'dev' then
  source = {
    url = repo_url:gsub('https', 'git')
  }
end

build = {
  type = 'builtin',
  install = {
      -- cannot use _VERSION
      bin = {
          "bin/nvimp",
          "bin/texluap",
          "bin/pandocp",
          "bin/neomuttp"
      },
  },
}

deploy = {
  wrap_bin_scripts = false
}
