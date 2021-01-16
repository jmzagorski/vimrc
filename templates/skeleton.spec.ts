import { bootstrap } from "aurelia-bootstrapper";
import { StageComponent } from "aurelia-testing";
import { PLATFORM } from "aurelia-pal";

describe("${Component}", () => {
  let component;

  beforeEach(() => {
    component = StageComponent
      .withResources(PLATFORM.moduleName("app"))
      .inView("<app></app>");
  });

  afterEach(() => component.dispose());

  it("should render message", async () => {
    await component.create(bootstrap);
    fail("Setup this test fool!")
  });
});
