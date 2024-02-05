let
    pkgs = import <nixpkgs> { };
    lib = pkgs.lib;
    stdenv = pkgs.stdenv;
in pkgs.mkShell {
    buildInputs = with pkgs; [
        curl
    ];
    shellHook =
    ''
        alias mediaprune='if [ "$(docker ps -q -f status=running | wc -l)" -gt 0 ]; then docker system prune --all --volumes; else echo "NOT PRUNED: No active Docker containers."; fi'
        alias mediaup="mediaprune && docker compose --env-file ./.env.production up -d --force-recreate";
        alias aencrypt="ansible-vault encrypt vault.yaml --output vault/vault.yaml";
        alias adecrypt="ansible-vault decrypt vault/vault.yaml --output vault.yaml";
        alias rge="rg -g '!{**/migrations/*.py,**/node_modules/**,**/*.json,**/*.csv}'";
        alias rger="rg -g '!{**/migrations/*.py,**/node_modules/**,**/*.json,**/*.csv,**/*.R}'";
    '';

}
