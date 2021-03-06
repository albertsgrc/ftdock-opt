// Generated by CoffeeScript 1.10.0
(function() {
  var e, folder, fs, getDirectories, i, len, path, ref;

  e = require('child_process').execSync;

  fs = require('fs');

  path = require('path');

  module.exports = this;

  this.OPTIMIZED_PROGRAMS_PATH = '../optimizations/sources/3D_Dock/progs/';

  this.ORIGINAL_PROGRAM_PATH = '../original/sources/3D_Dock/progs';

  this.EXECUTABLES_DIR = "../execs";

  this.INPUTS = ["-static,../inputs/2pka.parsed,-mobile,../inputs/5pti.parsed", "-static,../inputs/1hba.parsed,-mobile,../inputs/5pti.parsed", "-static,../inputs/4hhb.parsed,-mobile,../inputs/5pti.parsed", "-static,../inputs/1ACB_rec.parsed,-mobile,../inputs/1ACB_lig.parsed"];

  this.DEFAULT_ARGS = '\"-static 2pka.parsed -mobile 5pti.parsed\"';

  this.PROGRAMS = [
    {
      name: '000-original',
      path: this.ORIGINAL_PROGRAM_PATH
    }
  ];

  this.OPTIM = "../scripts-js/optim/optim";

  getDirectories = function(p) {
    var folder, i, len, ref, results;
    ref = fs.readdirSync(p);
    results = [];
    for (i = 0, len = ref.length; i < len; i++) {
      folder = ref[i];
      if (fs.statSync(path.join(p, folder)).isDirectory() && folder[0] !== 'n') {
        results.push(folder);
      }
    }
    return results;
  };

  ref = getDirectories(this.OPTIMIZED_PROGRAMS_PATH).sort();
  for (i = 0, len = ref.length; i < len; i++) {
    folder = ref[i];
    this.PROGRAMS.push({
      name: folder,
      path: path.join(this.OPTIMIZED_PROGRAMS_PATH, folder)
    });
  }

}).call(this);
