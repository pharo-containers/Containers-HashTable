Class {
	#name : #CTPrimeObject,
	#superclass : #Object,
	#category : #'Containers-Hashtable-Tests-ObjectTester'
}

{ #category : #comparing }
CTPrimeObject >> hash [
	^self identityHash * 100799
]
