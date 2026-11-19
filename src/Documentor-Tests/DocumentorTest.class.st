"
Tests for Documentor.
"
Class {
	#name : 'DocumentorTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'tests' }
DocumentorTest >> report [

	^ (Documentor on: OrderedCollection) report
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsClassName [

	self assert: (self report includesSubstring: 'OrderedCollection')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsSuperclass [

	self assert: (self report includesSubstring: 'SequenceableCollection')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsFields [

	self assert: (self report includesSubstring: 'firstIndex')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsPackage [

	self assert: (self report includesSubstring: 'Collections-Sequenceable')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsHierarchy [

	self assert: (self report includesSubstring: 'Hierarchy').
	self assert: (self report includesSubstring: 'SequenceableCollection')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsMethods [

	self assert: (self report includesSubstring: 'Methods').
	self assert: (self report includesSubstring: 'addFirst:')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsMetrics [

	self assert: (self report includesSubstring: 'Metrics').
	self assert: (self report includesSubstring: 'Depth of inheritance')
]

{ #category : 'tests' }
DocumentorTest >> testReportContainsLinter [

	self assert: (self report includesSubstring: 'Linter').
	self assert: (self report includesSubstring: 'cyclomatic')
]

{ #category : 'tests' }
DocumentorTest >> testFirstParagraphOfComment [

	self
		assert: (Documentor on: DocumentorFixture) firstParagraphOfComment
		equals: 'I am a fixture used by the Documentor tests.'
]

{ #category : 'tests' }
DocumentorTest >> testFirstCommentOfMethodWithoutComment [

	self
		assert: ((Documentor on: DocumentorFixture) firstCommentOf: DocumentorFixture >> #constant)
		equals: ''
]
