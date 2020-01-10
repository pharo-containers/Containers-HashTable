Class {
	#name : #BaselineOfCOntainersHashTable,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersHashTable
}

{ #category : #baseline }
BaselineOfCOntainersHashTable >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package: 'Containers-HashTable'.
			spec package: 'Containers-HashTable-Tests' with: [ spec requires: 'Containers-HashTable' ].
			
			spec group: 'default' with: #('Containers-HashTable' 'Containers-HashTable-Tests')
		]
]
