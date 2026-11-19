"
I produce a Microdown report describing a class: identity, comment, hierarchy, methods, metrics and lint results.
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

{ #category : 'accessing' }
Documentor >> targetClass: aClass [

	targetClass := aClass
]

{ #category : 'reporting' }
Documentor >> report [

	builder := MicMicrodownTextualBuilder new.
	self buildHeader.
	self buildBasicInfo.
	self buildComment.
	self buildHierarchy.
	self buildMethods.
	self buildMetrics.
	self buildLinter.
	^ builder contents
]

{ #category : 'reporting' }
Documentor >> buildHeader [

	builder header: [ builder text: targetClass name ] withLevel: 1
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
Documentor >> firstParagraphOfComment [

	| paragraph |
	paragraph := OrderedCollection new.
	targetClass comment lines do: [ :line |
		line trimBoth isEmpty ifTrue: [ ^ ' ' join: paragraph ].
		paragraph add: line trimBoth ].
	^ ' ' join: paragraph
]

{ #category : 'reporting' }
Documentor >> buildComment [

	builder paragraph: [ builder text: self firstParagraphOfComment ]
]

{ #category : 'reporting' }
Documentor >> buildHierarchy [

	builder header: [ builder text: 'Hierarchy' ] withLevel: 2.
	builder unorderedListDuring: [
		targetClass allSuperclasses reversed do: [ :each |
			builder item: [ builder text: each name ] ] ]
]

{ #category : 'reporting' }
Documentor >> firstCommentOf: aMethod [

	| comments |
	comments := aMethod ast comments.
	^ comments isEmpty
		  ifTrue: [ '' ]
		  ifFalse: [ comments first contents ]
]

{ #category : 'reporting' }
Documentor >> buildMethods [

	builder header: [ builder text: 'Methods' ] withLevel: 2.
	builder unorderedListDuring: [
		targetClass localMethods do: [ :method |
			builder item: [
				builder monospace: method selector.
				builder text: ' : '.
				builder text: (self firstCommentOf: method) ] ] ]
]

{ #category : 'reporting' }
Documentor >> buildMetric: aLabel value: aNumber [

	builder item: [
		builder text: aLabel.
		builder text: aNumber printString ]
]

{ #category : 'reporting' }
Documentor >> buildSelectorsItem: aLabel from: aCollectionOfMethods [

	builder item: [
		builder text: aLabel.
		aCollectionOfMethods
			do: [ :each | builder monospace: each selector ]
			separatedBy: [ builder text: ' ' ] ]
]

{ #category : 'reporting' }
Documentor >> buildMetrics [

	| metrics |
	metrics := DocumentorMetrics on: targetClass.
	builder header: [ builder text: 'Metrics' ] withLevel: 2.
	builder unorderedListDuring: [
		self buildMetric: 'Depth of inheritance: ' value: metrics depthOfInheritance.
		self buildMetric: 'Inherited fields: ' value: metrics numberOfInheritedFields.
		self buildMetric: 'Defined fields: ' value: metrics numberOfDefinedFields.
		self buildMetric: 'Defined methods: ' value: metrics numberOfDefinedMethods.
		self buildMetric: 'Inherited methods: ' value: metrics numberOfInheritedMethods.
		self buildMetric: 'Methods calling super: ' value: metrics numberOfMethodsCallingSuper.
		self buildSelectorsItem: 'Long methods: ' from: (metrics longMethods: 10) ]
]

{ #category : 'reporting' }
Documentor >> buildLinter [

	| linter |
	linter := DocumentorLinter on: targetClass.
	builder header: [ builder text: 'Linter' ] withLevel: 2.
	builder unorderedListDuring: [
		self
			buildSelectorsItem: 'Methods not accessing instance variables: '
			from: linter methodsNotAccessingInstanceVariables.
		self
			buildSelectorsItem: 'Methods accessing neither self nor instance variables: '
			from: linter methodsNotAccessingSelfNorInstanceVariables.
		self
			buildMetric: 'Total cyclomatic complexity: '
			value: linter totalCyclomaticComplexity ]
]
