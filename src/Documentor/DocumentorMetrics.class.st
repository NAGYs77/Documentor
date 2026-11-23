"
I compute simple software metrics about a class.
"
Class {
	#name : 'DocumentorMetrics',
	#superclass : 'Object',
	#instVars : [
		'targetClass'
	],
	#category : 'Documentor',
	#package : 'Documentor'
}

{ #category : 'instance creation' }
DocumentorMetrics class >> on: aClass [

	^ self new targetClass: aClass; yourself
]

{ #category : 'accessing' }
DocumentorMetrics >> targetClass: aClass [

	targetClass := aClass
]

{ #category : 'metrics' }
DocumentorMetrics >> depthOfInheritance [

	^ targetClass allSuperclasses size
]

{ #category : 'metrics' }
DocumentorMetrics >> numberOfDefinedFields [

	^ targetClass instVarNames size
]

{ #category : 'metrics' }
DocumentorMetrics >> numberOfInheritedFields [

	^ targetClass allInstVarNames size - targetClass instVarNames size
]

{ #category : 'metrics' }
DocumentorMetrics >> numberOfDefinedMethods [

	^ targetClass localMethods size
]

{ #category : 'metrics' }
DocumentorMetrics >> numberOfInheritedMethods [

	^ targetClass superclass
		  ifNil: [ 0 ]
		  ifNotNil: [ :parent | parent allSelectors size ]
]

{ #category : 'metrics' }
DocumentorMetrics >> numberOfMethodsCallingSuper [

	^ targetClass localMethods count: [ :method |
		  method ast sendNodes anySatisfy: [ :send | send receiver isVariable and: [ send receiver name = 'super' ] ] ]
]

{ #category : 'metrics' }
DocumentorMetrics >> longMethods: maxLines [

	^ targetClass localMethods select: [ :method |
		  method sourceCode lines size > maxLines ]
]
