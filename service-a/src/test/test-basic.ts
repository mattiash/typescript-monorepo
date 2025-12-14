import { test } from "purple-tape";
import { double, trueish } from "../lib/basic";
import { file2 } from "@tsmr/common/utils/file2";

test("Basic A", (t) => {
  t.true(trueish, "trueish works");
  t.pass("All is well");
});

test("Double", (t) => {
  t.equal(double(2), 4);
});

test("Import from @tsmr/common/utils/file2", (t) => {
  t.equal(file2, "Hello");
});
