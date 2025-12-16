import { test } from "purple-tape";
import { plus } from "..";

test("plus", (t) => {
  t.equal(plus(1, 2), 3);
});
