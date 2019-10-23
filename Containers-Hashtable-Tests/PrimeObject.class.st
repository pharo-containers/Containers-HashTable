Class {
	#name : #PrimeObject,
	#superclass : #Object,
	#category : #'Containers-Hashtable-Tests-ObjectTester'
}

{ #category : #comparing }
PrimeObject >> hash [
	^self identityHash * 100799
]
