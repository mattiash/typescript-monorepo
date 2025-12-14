import "@tsmr/common";
import colors from "yoctocolors";
import { emojify } from "node-emoji";
import { file2 } from "@tsmr/common/utils/file2";

console.log(emojify(":unicorn: ") + colors.green("service-a/index.ts"));
console.log(file2);
