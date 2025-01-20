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

        python = {
          path = ./python;
          description = "Development environment for Python";
        };

        go = {
          path = ./go;
          description = "Development environment for Golang";
        };
      };

      defaultTemplate = self.templates.devenv;
    };
}
