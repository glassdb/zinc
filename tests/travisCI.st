"Load and run tests to be performed by TravisCI"
| gitPath |
Transcript cr; show: 'travis---->travisCI.st'.
gitPath := (FileDirectory default directoryNamed: 'git_cache') fullName.

(MCWorkingCopy allManagers 
  collect: [ :wc | wc ancestors first name ]) sorted 
    do: [:packageName |
      Transcript cr; show: packageName].

"Load Tode ... "
Metacello new
	baseline: 'Zinc';
  repository: 'filetree://', gitPath, '/zinc/repository';
  load: #('Tests' 'default').

(MCWorkingCopy allManagers 
  collect: [ :wc | wc ancestors first name ]) sorted 
    do: [:packageName |
      Transcript cr; show: packageName].

"Run the Tode tests"
TravisCIHarness
  value: #( 'BaselineOfZinc' )
  value: 'TravisCISuccess.txt' 
  value: 'TravisCIFailure.txt'.
