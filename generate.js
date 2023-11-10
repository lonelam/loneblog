const Hexo = require("hexo");
const markedKatex = require("marked-katex-extension");
async function main() {
  const hexo = new Hexo(process.cwd(), { debug: true });
  hexo.extend.filter.register("marked:extensions", function (extensions) {
    extensions.push(markedKatex({}));
  });
  await hexo.init();
  await hexo.call("generate", {});
  hexo.exit();
}
main();
