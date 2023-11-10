const Hexo = require("hexo");
const markedKatex = require("marked-katex-extension");
async function main() {
  const hexo = new Hexo(process.cwd(), {});
  hexo.extend.filter.register("marked:extensions", function (extensions) {
    const addedExtentions = markedKatex({
      throwOnError: false,
    });
    extensions.push(...addedExtentions.extensions);
  });
  await hexo.init();
  await hexo.call("generate", {});
  hexo.exit();
}
main();
