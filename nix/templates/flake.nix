{
  description = "A collection of development flake templates";

  outputs =
    { self }:
    {
      templates = {
        devenv = {
          path = ./devenv;
          description = "A basic flake for development with no packages";
        };

        ocaml = {
          path = ./ocaml;
          description = "Development environment for OCaml";
        };

      };

      defaultTemplate = self.templates.devenv;
    };
}
