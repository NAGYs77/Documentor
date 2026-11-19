"
I report suspicious methods of a class, using DocumentorMethodVisitor on each method AST.
"
Class {
	#name : 'DocumentorLinter',
	#superclass : 'Object',
	#instVars : [
		'targetClass'
	],
	#category : 'Documentor',
	#package : 'Documentor'
}

{ #category : 'instance creation' }
DocumentorLinter class >> on: aClass [

	^ self new targetClass: aClass; yourself
]

{ #category : 'accessing' }
DocumentorLinter >> targetClass: aClass [

	targetClass := aClass
]

{ #category : 'analysis' }
DocumentorLinter >> analyze: aMethod [

	| visitor |
	visitor := DocumentorMethodVisitor instVarNames: targetClass allInstVarNames.
	aMethod ast acceptVisitor: visitor.
	^ visitor
]

{ #category : 'analysis' }
DocumentorLinter >> methodsNotAccessingInstanceVariables [

	^ targetClass localMethods reject: [ :method |
		  (self analyze: method) usesInstanceVariable ]
]

{ #category : 'analysis' }
DocumentorLinter >> methodsNotAccessingSelfNorInstanceVariables [

	^ targetClass localMethods reject: [ :method |
		  | visitor |
		  visitor := self analyze: method.
		  visitor usesSelf or: [ visitor usesInstanceVariable ] ]
]

{ #category : 'analysis' }
DocumentorLinter >> totalCyclomaticComplexity [

	^ targetClass localMethods inject: 0 into: [ :sum :method |
		  sum + (self analyze: method) cyclomaticComplexity ]
]
