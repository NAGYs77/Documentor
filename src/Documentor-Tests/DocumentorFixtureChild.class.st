"
I am a subclass of the fixture, used to test super sends.
"
Class {
	#name : 'DocumentorFixtureChild',
	#superclass : 'DocumentorFixture',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'fixture' }
DocumentorFixtureChild >> constant [

	^ super constant + 1
]
