{ config, lib, pkgs, specialArgs, ... }:
let
    params = specialArgs.systemParams;
    userEmail = params.user.email;
    userId = params.user.id;
    userLanguage = params.user.language;
    userName = params.user.name;
in {
    home = {
        homeDirectory = "/Users/${ userId }";
        stateVersion = "24.05";
        username = userId;
    };

    home.file = {
        ".aws/config".text = ''
        [default]
        region = eu-central-1
        output = json
        '';
    };

    home.language.base = userLanguage;

    programs.git = {
        includes = [
            {
                condition = "gitdir:~/SourceCode/github.com/egonbraun/";
                contents = {
                    user = {
                        name = userName;
                        email = userEmail;
                    };
                };
            }
            {
                condition = "gitdir:~/SourceCode/github.com/mundoalem/";
                contents = {
                    user = {
                        name = userName;
                        email = userEmail;
                    };
                };
            }
        ];
    };
}
