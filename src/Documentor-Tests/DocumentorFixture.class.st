"
I am a fixture used by the Documentor tests.

I have known fields and methods.
"
Class {
	#name : 'DocumentorFixture',
	#superclass : 'Object',
	#instVars : [
		'value'
	],
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'fixture' }
DocumentorFixture >> constant [

	^ 42
]

{ #category : 'fixture' }
DocumentorFixture >> readsValue [

	^ value
]

{ #category : 'fixture' }
DocumentorFixture >> usesSelfOnly [

	^ self printString
]

{ #category : 'fixture' }
DocumentorFixture >> branching [

	value > 0 ifTrue: [ value := 1 ].
	[ value < 3 ] whileTrue: [ value := value + 1 ].
	^ value
]
