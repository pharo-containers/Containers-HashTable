Class {
	#name : #CTDictionarySpeedTest,
	#superclass : #Object,
	#instVars : [
		'stepsize',
		'testsize'
	],
	#category : #'Containers-Hashtable-Tests-SUnit'
}

{ #category : #finding }
CTDictionarySpeedTest class >> findBigOnes [
	"self findBigOnes"
	^(Set allSubclasses
		add: Set;
		yourself) in: [ :classes |
			(classes gather: [ :each | each allInstances])
				select: [ :each | each size > 4000 ] ]
]

{ #category : #replacing }
CTDictionarySpeedTest class >> replaceBigs: aClass with: anOtherClass [
	"self replaceBigs: WeakSet with: WeakHashSet"
	| new |
	(aClass allInstances select: [ :each | each size > 4000 ]) do: [ :each |
		new := anOtherClass new.
		new addAll: each.
		new become: each ].
]

{ #category : #finding }
CTDictionarySpeedTest class >> replaceMCInstances [
	"self replaceMCInstances"
	| oldSet newSet newSize oldSize |
	oldSet := MCDefinition classPool at: #Instances.
	newSet := CTHashSet new.
	oldSize := oldSet size.
	newSize := oldSet inject: 0 into: [ :s :each | s + 1].
	self inform: ' old size: ' , oldSize asString , ' new size: ' , newSize asString , ' '.
	"oldSet do: [ :each | newSet add: each ] displayingProgress: 'copying MCDefinition Instances'.
	 MCDefinition classPool at: #Instances put: newSet."
]

{ #category : #testing }
CTDictionarySpeedTest class >> testClass: aClass [
	| step test ord |
	step := 100.
	test := aClass new.

	[ test size >= 100000 ] whileFalse: [ 
		ord := OrderedCollection new: step.
		step timesRepeat: [
			test at: (ord add: Object new) put: nil ].
		Transcript show: test size; tab.
		Transcript show: [ 
			10 timesRepeat: [
				ord do: [ :each |
					test at: each ] ] ]
			timeToRun.
		Transcript cr ].
]

{ #category : #testing }
CTDictionarySpeedTest class >> testClasses [
	"DictionarySpeedTest testClasses"
	self new testClasses
]

{ #category : #testing }
CTDictionarySpeedTest class >> testDictonary [
	| step test ord |
	step := 100.
	test := Dictionary new.

	[ test size >= 100000 ] whileFalse: [ 
		ord := OrderedCollection new: step.
		step timesRepeat: [
			test at: (ord add: Object new) put: nil ].
		Transcript show: test size; tab.
		Transcript show: [ 
			10 timesRepeat: [
				ord do: [ :each |
					test at: each ] ] ]
			timeToRun.
		Transcript cr ].
]

{ #category : #testing }
CTDictionarySpeedTest class >> testObjects [
	"DictionarySpeedTest testObjects"
	self new testObjects
]

{ #category : #finding }
CTDictionarySpeedTest class >> testSizes: oldSet [
	"self testSizes: (MCDefinition classPool at: #Instances)"
	"self testSizes: (Symbol classPool at: #SymbolTable)"
	| newSize oldSize |
	oldSize := oldSet size.
	newSize := oldSet inject: 0 into: [ :s :each | s + 1].
	self inform: ' old size: ' , oldSize asString , ' new size: ' , newSize asString , ' '.
]

{ #category : #utility }
CTDictionarySpeedTest >> asSelector: aClass [
	^ ( 'test' , aClass name, '0n:' ) asSymbol
]

{ #category : #'initialize-release' }
CTDictionarySpeedTest >> initialize [
	super initialize.
	self stepsize: 100.
	self testsize: 10000.
]

{ #category : #accessing }
CTDictionarySpeedTest >> stepsize [
	^stepsize
]

{ #category : #accessing }
CTDictionarySpeedTest >> stepsize: anObject [
	stepsize := anObject
]

{ #category : #testing }
CTDictionarySpeedTest >> testClasses [
	| stream |
	self testDictionaryClasses do: [ :each |
		Transcript show: 'Testing: ' , each name asString ; cr.
		stream := FileStream fileNamed: each name , '.classdata' .
		self perform: #testDictionary:of:on:  withArguments: (Array with: each with: Object with: stream).
		stream close ].
	Transcript show: 'done' ; cr.
]

{ #category : #testing }
CTDictionarySpeedTest >> testDictionary: aDictionaryClass of: anObjectClass on: aStream [ 
	| test ord |
	test := aDictionaryClass new.
	[ test size >= self testsize] whileFalse: [
			ord := OrderedCollection new: self stepsize.
			self stepsize timesRepeat: [ 
				test at: ( ord add: anObjectClass new ) put: nil ].
			aStream
				nextPutAll: test size asString;
				tab.
			aStream nextPutAll:
				[
					10 timesRepeat: [ 
						ord do: [ :each | test at: each ] ]
				] timeToRun asString.
		aStream cr ]
]

{ #category : #accessing }
CTDictionarySpeedTest >> testDictionaryClasses [
	^Array
		with: Dictionary
		with: IdentityDictionary
		with: CTHashTable
		with: CTIdentityHashTable
]

{ #category : #accessing }
CTDictionarySpeedTest >> testObjectClasses [
	^Array
		with: Object
		with: CTPrimeObject
		"with: CVAutoincrementObject
		with: CIVAutoincrementObject
		with: RandomObject"
]

{ #category : #testing }
CTDictionarySpeedTest >> testObjects [
	| stream |
	self testObjectClasses do: [ :each |
		Transcript show: 'Testing: ' , each name asString ; cr.
		stream := FileStream fileNamed: each name , '.objectdata' .
		self perform: #testDictionary:of:on:  withArguments: (Array with: Dictionary with: each with: stream).
		stream close ].
	Transcript show: 'done' ; cr.
]

{ #category : #accessing }
CTDictionarySpeedTest >> testsize [
	^testsize
]

{ #category : #accessing }
CTDictionarySpeedTest >> testsize: anObject [
	testsize := anObject
]
