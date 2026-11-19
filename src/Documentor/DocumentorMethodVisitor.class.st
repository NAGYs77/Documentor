"
I visit the AST of one method and record whether it uses self, whether it uses instance variables, and its cyclomatic complexity.
"
Class {
	#name : 'DocumentorMethodVisitor',
	#superclass : 'RBProgramNodeVisitor',
	#instVars : [
		'usesSelf',
		'usesInstanceVariable',
		'cyclomaticComplexity',
		'instVarNames'
	],
	#category : 'Documentor',
	#package : 'Documentor'
}

{ #category : 'instance creation' }
DocumentorMethodVisitor class >> instVarNames: aCollection [

	^ self new setInstVarNames: aCollection; yourself
]

{ #category : 'initialization' }
DocumentorMethodVisitor >> initialize [

	super initialize.
	usesSelf := false.
	usesInstanceVariable := false.
	cyclomaticComplexity := 1.
	instVarNames := #(  )
]

{ #category : 'initialization' }
DocumentorMethodVisitor >> setInstVarNames: aCollection [

	instVarNames := aCollection
]

{ #category : 'accessing' }
DocumentorMethodVisitor >> usesSelf [

	^ usesSelf
]

{ #category : 'accessing' }
DocumentorMethodVisitor >> usesInstanceVariable [

	^ usesInstanceVariable
]

{ #category : 'accessing' }
DocumentorMethodVisitor >> cyclomaticComplexity [

	^ cyclomaticComplexity
]

{ #category : 'accessing' }
DocumentorMethodVisitor >> conditionalSelectors [

	^ #( #ifTrue: #ifFalse: #ifTrue:ifFalse: #ifFalse:ifTrue:
	     #whileTrue: #whileFalse: #whileTrue #whileFalse
	     #and: #or: #ifNil: #ifNotNil: #ifNil:ifNotNil: #ifNotNil:ifNil: )
]

{ #category : 'visiting' }
DocumentorMethodVisitor >> visitSelfNode: aNode [

	usesSelf := true
]

{ #category : 'visiting' }
DocumentorMethodVisitor >> visitVariableNode: aNode [

	aNode isSelf ifTrue: [ usesSelf := true ].
	(instVarNames includes: aNode name) ifTrue: [ usesInstanceVariable := true ].
	^ super visitVariableNode: aNode
]

{ #category : 'visiting' }
DocumentorMethodVisitor >> visitMessageNode: aNode [

	(self conditionalSelectors includes: aNode selector) ifTrue: [
		cyclomaticComplexity := cyclomaticComplexity + 1 ].
	^ super visitMessageNode: aNode
]
