Class {
	#name : #BaselineOfCOntainersHashtable,
	#superclass : #BaselineOf,
	#category : #BaselineOfContainersHashtable
}

{ #category : #baseline }
BaselineOfCOntainersHashtable >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do: [
			spec package: 'Containers-Hashtable'.
			spec package: 'Containers-Hashtable-Tests' with: [ spec requires: 'Containers-Hashtable' ].
			
			spec group: 'default' with: #('Containers-Hashtable' 'Containers-Hashtable-Tests')
		]
]
