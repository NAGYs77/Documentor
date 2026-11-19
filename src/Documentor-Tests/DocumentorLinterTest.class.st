"
Tests for DocumentorLinter and DocumentorMethodVisitor.
"
Class {
	#name : 'DocumentorLinterTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'tests' }
DocumentorLinterTest >> linter [

	^ DocumentorLinter on: DocumentorFixture
]

{ #category : 'tests' }
DocumentorLinterTest >> testMethodsNotAccessingInstanceVariables [

	| selectors |
	selectors := (self linter methodsNotAccessingInstanceVariables collect: #selector) asSet.
	self assert: (selectors includes: #constant).
	self assert: (selectors includes: #usesSelfOnly).
	self deny: (selectors includes: #readsValue).
	self deny: (selectors includes: #branching)
]

{ #category : 'tests' }
DocumentorLinterTest >> testMethodsNotAccessingSelfNorInstanceVariables [

	| selectors |
	selectors := (self linter methodsNotAccessingSelfNorInstanceVariables collect: #selector) asSet.
	self assert: (selectors includes: #constant).
	self deny: (selectors includes: #usesSelfOnly).
	self deny: (selectors includes: #readsValue)
]

{ #category : 'tests' }
DocumentorLinterTest >> testCyclomaticComplexityOfOneMethod [

	self
		assert: (self linter analyze: DocumentorFixture >> #branching) cyclomaticComplexity
		equals: 3.
	self
		assert: (self linter analyze: DocumentorFixture >> #constant) cyclomaticComplexity
		equals: 1
]

{ #category : 'tests' }
DocumentorLinterTest >> testTotalCyclomaticComplexity [

	self assert: self linter totalCyclomaticComplexity equals: 6
]
