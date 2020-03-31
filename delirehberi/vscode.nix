{config,lib,pkgs,...}:
let 
	all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
	my-hies = all-hies.selection {selector = p: {inherit (p) ghc864 ghc865;};};
in {
	programs.vscode.enable = true;
	programs.vscode.haskell.enable = true;
	programs.vscode.haskell.hie.enable = true;
	programs.vscode.haskell.hie.executablePath = "${my-hies}/bin/hie";
	programs.vscode.extensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
		{
			name = "brittany";
			publisher = "MaxGabriel";
			version = "0.0.9";
			sha256 = "1cfbzc8fmvfsxyfwr11vnszvirl47zzjbjp6rihg5518gf5wd36k";
			}
			{
			name= "mustache";
			version = "1.1.1";
			publisher = "dawhite";
			sha256 = "3e4ca631ec7589cbc33760dfdfc108b95d4ef5390c3563f6b063a3975fb118c9";
			}
			{
			name= "symfony-vscode";
			version = "1.0.2";
			publisher = "TheNouillet";
			sha256 = "dc45c8e60b0a32d9c9af39f63a1702a49e63284999b845c1fa737a1d674d6961";
			}
			{
			name= "vscode-intelephense-client";
			version="1.3.11";
			publisher="bmewburn";
			sha256="7a53591c3972adea1c8c8e139e2e1b85eddb941f3a8ce0029c5f4da2de58df6b";
			}
			{
			name= "vscode-php-getters-setters";
			version= "1.2.3";
			publisher= "phproberto";
			sha256= "5e8b8bc539c2340bbe6221062eb411c0c1d6a302192d7210a24d9dfc15396afd";
			}

			{
				name = "prettier-vscode";
				version = "3.20.0";
				publisher = "esbenp";
				sha256 = "09bm1h2ayx75vqwqfm43b7vq3383ph01gvs6r9zqqrzz18m5r1hi";
				}
				{
				name = "twig-language-2";
				version = "0.9.0";
				publisher = "mblode";
				sha256 = "86a20bb106ddea2eb9ab5251e748053251304c6fe6d13b5f8f592c9053691452";
				}
				{
				name = "Go";
				version = "0.13.1";
				publisher = "ms-vscode";
				sha256 = "b0a8ddc4cbe58796b82deeefc87007836dcaedd7d6591eaacbac20b0c84ba8a3";
				}
				{
				name = "vscode-wakatime";
				publisher = "WakaTime";
				version = "4.0.0";
				sha256 = "0bwxz8dg00k8frnvkvcngll5yaf9k7z13dg309vmw8xbdgkiyid4";
				}
				];
				programs.vscode.userSettings = {
				"files.autoSave" = "onFocusChange";
				"editor.formatOnSave" = false;
				"editor.tabSize" = 2;
				"editor.wordWrap" = "on";
				"editor.fontSize"= 18;
				"editor.defaultFormatter" = "esbenp.prettier-vscode";
				"files.associations"= {
				"*.hs"= "haskell";
				};
				"files.watcherExclude"={
				"**/.git/objects/**"=true;
				"**/.git/subtree-cache/**"=true;
				"**/node_modules/*/**"=true;
				};
				"[haskell]" = {
				"editor.defaultFormatter" = "MaxGabriel.brittany";
				};
				"brittany.stackEnable" = true;
				"php.suggest.basic" = false;
				"php.executablePath" = "${pkgs.php}/bin/php";
				"symfony-vscode.phpExecutablePath" = "${pkgs.php}/bin/php";
				"diffEditor.ignoreTrimWhitespace" = false;
				};
				home.packages = [
				my-hies
				pkgs.haskellPackages.brittany
				];

			}
