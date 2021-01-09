"
I defined a couple of methods to test speed of the implementation. 
See `self new testClasses` and `self new testObjects`
"
Class {
	#name : #CTDictionarySpeedTest,
	#superclass : #Object,
	#instVars : [
		'stepsize',
		'testsize'
	],
	#category : #'Containers-HashTable-Tests-SUnit'
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

{ #category : #accessing }
CTDictionarySpeedTest >> dictionaryClassesUnderTest [
	^ { Dictionary .  IdentityDictionary . CTHashTable . CTIdentityHashTable }
]

{ #category : #initialization }
CTDictionarySpeedTest >> initialize [
	super initialize.
	self stepSize: 100.
	self testSize: 10000.
]

{ #category : #accessing }
CTDictionarySpeedTest >> objectClassesUnderTest [
	^Array
		with: Object
		with: CTPrimeObject
		"with: CVAutoincrementObject
		with: CIVAutoincrementObject
		with: RandomObject"
]

{ #category : #accessing }
CTDictionarySpeedTest >> stepSize [
	^stepsize
]

{ #category : #accessing }
CTDictionarySpeedTest >> stepSize: anObject [
	stepsize := anObject
]

{ #category : #utility }
CTDictionarySpeedTest >> test: aCollectionOfClasses [
	"self new testClasses"
	aCollectionOfClasses do: [ :each |
		| stream |
		stream :=  (each name , '.classdata') asFileReference writeStream .
		self perform: #testDictionary:of:on:  withArguments: (Array with: each with: Object with: stream).
		stream close ].
	
]

{ #category : #testing }
CTDictionarySpeedTest >> testClasses [
	"self new testClasses"
	
	self test: self dictionaryClassesUnderTest 
]

{ #category : #utility }
CTDictionarySpeedTest >> testDictionary: aDictionaryClass of: anObjectClass on: aStream [ 
	| test ord |
	test := aDictionaryClass new.
	[ test size >= self testSize ] whileFalse: [
			ord := OrderedCollection new: self stepSize.
			self stepSize timesRepeat: [ 
				test at: (ord add: anObjectClass new) put: nil ].
			aStream
				nextPutAll: test size asString;
				tab.
			aStream nextPutAll:
				[
					1000 timesRepeat: [ 
						ord do: [ :each | test at: each ] ]
				] timeToRun asString.
		aStream cr ]
]

{ #category : #testing }
CTDictionarySpeedTest >> testObjects [
	"self new testObjects"
	| stream |
	self objectClassesUnderTest do: [ :each |
		Transcript show: 'Testing: ' , each name asString ; cr.
		stream := (each name , '.objectdata') asFileReference writeStream.
		self perform: #testDictionary:of:on:  withArguments: (Array with: Dictionary with: each with: stream).
		stream close ].
	Transcript show: 'done' ; cr.
]

{ #category : #accessing }
CTDictionarySpeedTest >> testSize [
	^testsize
]

{ #category : #accessing }
CTDictionarySpeedTest >> testSize: anObject [
	testsize := anObject
]
