/*
 * Copyright (c) 2020 Ableton AG, Berlin
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

import UIKit

class PresetChooser: UIBarButtonItem {
  var preset: PerformancePreset {
    get {
      return segmentedControl.selectedSegmentIndex != UISegmentedControl.noSegment
        ? PerformancePreset(rawValue: segmentedControl.selectedSegmentIndex)!
        : PerformancePreset.customPreset
    }
    set {
      segmentedControl.selectedSegmentIndex = newValue != PerformancePreset.customPreset
        ? newValue.rawValue : UISegmentedControl.noSegment
    }
  }

  private let segmentedControl = UISegmentedControl(items: ["Standard", "Optimal"])

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    segmentedControl.widthAnchor.constraint(equalToConstant: 200).isActive = true
    segmentedControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
    segmentedControl.addTarget(
      self, action: #selector(onValueChanged), for: .valueChanged)
    customView = segmentedControl
  }

  @objc private func onValueChanged() {
    if let action = action {
      _ = target?.perform(action, with: self)
    }
  }
}
