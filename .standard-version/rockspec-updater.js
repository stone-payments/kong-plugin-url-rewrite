const capturingRegex = /version = "(?<version>[\d.]*)-0"/;

module.exports.readVersion = function (contents) {
  const { version } = contents.match(capturingRegex).groups;
  return version;
};

module.exports.writeVersion = function (contents, version) {
  const replacer = () => `version = "${version}-0"`;

  return contents.replace(capturingRegex, replacer);
};
