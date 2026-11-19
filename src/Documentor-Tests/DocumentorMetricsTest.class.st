"
Tests for DocumentorMetrics.
"
Class {
	#name : 'DocumentorMetricsTest',
	#superclass : 'TestCase',
	#category : 'Documentor-Tests',
	#package : 'Documentor-Tests'
}

{ #category : 'tests' }
DocumentorMetricsTest >> testDepthOfInheritance [

	self
		assert: (DocumentorMetrics on: DocumentorFixtureChild) depthOfInheritance
		equals: DocumentorFixtureChild allSuperclasses size
]

{ #category : 'tests' }
DocumentorMetricsTest >> testDefinedFields [

	self assert: (DocumentorMetrics on: DocumentorFixture) numberOfDefinedFields equals: 1
]

{ #category : 'tests' }
DocumentorMetricsTest >> testInheritedFields [

	self assert: (DocumentorMetrics on: DocumentorFixtureChild) numberOfInheritedFields equals: 1.
	self assert: (DocumentorMetrics on: DocumentorFixtureChild) numberOfDefinedFields equals: 0
]

{ #category : 'tests' }
DocumentorMetricsTest >> testDefinedMethods [

	self assert: (DocumentorMetrics on: DocumentorFixture) numberOfDefinedMethods equals: 4
]

{ #category : 'tests' }
DocumentorMetricsTest >> testInheritedMethods [

	self
		assert: (DocumentorMetrics on: DocumentorFixtureChild) numberOfInheritedMethods
		equals: DocumentorFixture allSelectors size
]

{ #category : 'tests' }
DocumentorMetricsTest >> testMethodsCallingSuper [

	self assert: (DocumentorMetrics on: DocumentorFixtureChild) numberOfMethodsCallingSuper equals: 1.
	self assert: (DocumentorMetrics on: DocumentorFixture) numberOfMethodsCallingSuper equals: 0
]

{ #category : 'tests' }
DocumentorMetricsTest >> testLongMethods [

	| metrics |
	metrics := DocumentorMetrics on: DocumentorFixture.
	self assert: ((metrics longMethods: 3) collect: #selector) asArray equals: #( #branching ).
	self assert: (metrics longMethods: 1000) isEmpty
]
