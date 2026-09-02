import fs from "node:fs";
import path from "node:path";
import sharp from "sharp";

const dir = "public/cards";
for (const file of fs.readdirSync(dir).filter((name) => name.endsWith(".png"))) {
  const src = path.join(dir, file);
  const dest = src.replace(/\.png$/i, ".jpg");
  await sharp(src).resize(1200, 900, { fit: "cover" }).jpeg({ quality: 78, mozjpeg: true }).toFile(dest);
  fs.unlinkSync(src);
  console.log(dest, fs.statSync(dest).size);
}
