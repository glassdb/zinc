"Load and run tests to be performed by TravisCI"
| gitPath |
Transcript cr; show: 'travis---->travisCI.st'.
gitPath := (FileDirectory default directoryNamed: 'git_cache') fullName.

"Load the bleeding edge for Metacello...at least for now I want to pick up GLASS-specific bugfixes"
Metacello new
  baseline: 'Metacello';
  repository: 'github://dalehenrich/metacello-work:master/repository';
  get.
Metacello new
  baseline: 'Metacello';
  repository: 'github://dalehenrich/metacello-work:master/repository';
  onConflict: [:ex | ex allow];
  load.

"Load Zinc ... "
Metacello new
	baseline: 'Zinc';
  repository: 'filetree://', gitPath, '/zinc/repository';
  load: #('Tests' 'default').

"Run the Zinc tests"
TravisCIHarness
  value: #( 'BaselineOfZinc' )
  value: 'TravisCISuccess.txt' 
  value: 'TravisCIFailure.txt'.
