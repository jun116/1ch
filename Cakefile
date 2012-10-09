sys  = require 'sys'
fs   = require 'fs'
exec = require('child_process').exec

COMMAND = 'coffee'
OPTIONS = '-wcb'
SRCDIR = './coffee'    # *.coffeeファイルがあるディレクトリへのパス
OUTDIR = '.'            # *.jsファイルの保存先

task 'all', 'compile target files', ->
  for target in targetList
    try
      coffee = makePath [SRCDIR, target.path, target.file], ".coffee"
      cs = fs.statSync coffee
    catch error
      sys.puts "file not found: #{error.path}"
      continue
    try
      js = fs.statSync (makePath [OUTDIR, target.path, target.file], ".js")
      #continue if cs.mtime < js.mtime  # 更新されていなければ次のターゲットへ
    catch error
      null 
    try
      dir = fs.statSync "#{OUTDIR}/#{target.path}"
    catch error
      fs.mkdirSync "#{OUTDIR}/#{target.path}", "755"
    command = "#{COMMAND} #{OPTIONS} -o #{OUTDIR}/#{target.path} #{coffee}" 
    sys.puts command
    exec command

task 'clean', 'delete target files', ->
  for target in targetList
    exec "rm #{OUTDIR}/#{target}.js"

#---- func ---

makePath = (dirs, suffix)->
  path = ""
  for d in dirs
    path = "#{path}#{d}"
    path = "#{path}/" if d
  path = path.replace /\/$/, ""
  path = path.replace /\/{2,}$/, "/"
  path = "#{path}#{suffix}"

targetList = []
targetFiles = (path = "") ->
  console.log "path", path
  for f in fs.readdirSync "#{SRCDIR}/#{path}"
    console.log "a:" + path, f
    if f.match /^(\w+)\.coffee$/
      console.log "b:" + path, RegExp.$1
      targetList.push 
        path : path
        file : RegExp.$1 
      continue
    unless f.match /.*\..*/
      f = path + "/" + f unless path == ""
      targetFiles f
targetFiles()
