"Load and run tests to be performed by TravisCI"
| gitPath |
Transcript cr; show: 'travis---->travisCI.st'.
gitPath := (FileDirectory default directoryNamed: 'git_cache') fullName.

"Load latest GLASS1 from github"
Metacello new
  baseline: 'GLASS1';
  repository: 'github://glassdb/glass:master/repository';
  load.


"Load Zinc... "
Metacello new
  baseline: 'Zinc';
  repository: 'filetree://', gitPath, '/zinc/repository';
  load: #('Tests' 'Core').

"Run the Tode tests"
TravisCIHarness
  value: #( 'BaselineOfZinc' )
  value: 'TravisCISuccess.txt' 
  value: 'TravisCIFailure.txt'.
