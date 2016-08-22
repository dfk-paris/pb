'use strict';

var ejs = require('ejs');
var fs = require('fs');
var crypto = require('crypto');
var async = require('async');

class IndexRenderer {
  constructor() {
    this.file_opts = {encoding: 'utf8'};
  }

  read(filename) {
    return fs.readFileSync(filename, this.file_opts);
  }

  tpl() {
    return this.read('widgets/index.html.ejs');
  }

  digest(filename) {
    var hash = crypto.createHash('sha256');
    return hash.update(this.read(filename)).digest('hex').slice(0,9);
  }

  stylesheet_path(filename) {
    return filename + '?' + this.digest('public/' + filename);
  }

  script_path(filename) {
    return this.stylesheet_path(filename);
  }

  render() {
    return ejs.render(this.tpl(), this);
  }
}

var ir = new IndexRenderer();
console.log(ir.render());