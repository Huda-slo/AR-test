//
//  ARViewContainer.swift
//  AR-test
//
//  Created by Huda Almadi on 23/01/2026.
//
import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {

    func makeUIView(context: Context) -> ARView {

        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]

        if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
            config.sceneReconstruction = .mesh
        }

        arView.session.run(config)

        let mesh = MeshResource.generateBox(
            size: 0.1,
            cornerRadius: 0.005
        )

        let material = SimpleMaterial(
            color: .gray,
            roughness: 0.15,
            isMetallic: true
        )

        let model = ModelEntity(
            mesh: mesh,
            materials: [material]
        )

        model.position = [0, 0.05, 0]

        let anchor = AnchorEntity(
            .plane(
                .horizontal,
                classification: .any,
                minimumBounds: [0.2, 0.2]
            )
        )

        anchor.addChild(model)
        arView.scene.addAnchor(anchor)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    }
}

