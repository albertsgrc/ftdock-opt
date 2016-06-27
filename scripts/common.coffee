{ execSync: e } = require 'child_process'
fs = require 'fs'
path = require 'path'

module.exports = @

@OPTIMIZED_PROGRAMS_PATH = '../optimizations/sources/3D_Dock/progs/'
@ORIGINAL_PROGRAM_PATH = '../original/sources/3D_Dock/progs'
@EXECUTABLES_DIR = "../execs"
@INPUTS = [
    "-static,../inputs/2pka.parsed,-mobile,../inputs/5pti.parsed"
    "-static,../inputs/1hba.parsed,-mobile,../inputs/5pti.parsed"
    "-static,../inputs/4hhb.parsed,-mobile,../inputs/5pti.parsed"
    "-static,../inputs/1ACB_rec.parsed,-mobile,../inputs/1ACB_lig.parsed"
]
@DEFAULT_ARGS = '\"-static 2pka.parsed -mobile 5pti.parsed\"'

@PROGRAMS = [{ name: '000-original', path: @ORIGINAL_PROGRAM_PATH }]

@OPTIM = "../scripts/optim/optim"

getDirectories = (p) ->
    (folder for folder in fs.readdirSync(p) when fs.statSync(path.join(p, folder)).isDirectory() and folder[0] isnt 'n')

for folder in getDirectories(@OPTIMIZED_PROGRAMS_PATH).sort()
    @PROGRAMS.push({ name: folder, path: path.join(@OPTIMIZED_PROGRAMS_PATH, folder) })
