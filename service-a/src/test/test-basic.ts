import { test } from "purple-tape";
import { double, trueish } from "../lib/basic";

test("Basic A", (t) => {
  t.true(trueish, "trueish works");
  t.pass("All is well");
});

test("Double", (t) => {
  t.equal(double(2), 4);
});
