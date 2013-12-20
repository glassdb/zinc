as yet unclassified
isInBufferEmpty
  "Any data in the buffer?"

  (lastRead = 0 and: [ inNextToWrite == 1 ])
    ifTrue: [ ^ true ].
  ^ lastRead + 1 = inNextToWrite