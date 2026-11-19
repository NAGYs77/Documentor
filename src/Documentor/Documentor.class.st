"
Je produis un rapport Microdown decrivant une classe.
"
Class {
	#name : 'Documentor',
	#superclass : 'Object',
	#instVars : [
		'targetClass',
		'builder'
	],
	#category : 'Documentor',
	#package : 'Documentor'
}

{ #category : 'instance creation' }
Documentor class >> on: aClass [
	^ self new targetClass: aClass; yourself
]

{ #category : 'reporting' }
Documentor >> buildBasicInfo [
	builder unorderedListDuring: [
		builder item: [
			builder text: 'a subclass of '.
			builder monospace: targetClass superclass name ].
		builder item: [
			builder text: 'has the following fields: '.
			targetClass instVarNames
				do: [ :each | builder monospace: each ]
				separatedBy: [ builder text: ' ' ] ].
		builder item: [
			builder text: 'defined in package '.
			builder monospace: targetClass package name ] ]
]

{ #category : 'reporting' }
Documentor >> buildHeader [
	builder header: [ builder text: targetClass name ] withLevel: 1
]

{ #category : 'reporting' }
Documentor >> report [
	builder := MicMicrodownTextualBuilder new.
	self buildHeader.
	self buildBasicInfo.
	^ builder contents
]

{ #category : 'accessing' }
Documentor >> targetClass: aClass [
	targetClass := aClass
]
