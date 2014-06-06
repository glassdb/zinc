private
handleError: anException
  [ 
  | messageText data stream |
  "Handle different argument arrangements (probably introduced in 2.3.2)"
  messageText := anException messageText.
  data := messageText isNil
    ifTrue: [ anException description ]
    ifFalse: [ messageText ].
  stream := WriteStream on: String new.
  stream
    cr;
    nextPutAll: anException description;
    cr;
    nextPutAll: '---' , Time now printString;
    cr;
    nextPutAll: (GsProcess stackReportToLevel: 100);
    cr;
    yourself.
  GsFile gciLogServer: stream contents ]
    on: Error
    do: [ :e | self notifyUnreportableError: anException description ]