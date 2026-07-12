//
//  PostRecipientSheet.swift
//  Chal4_ADA
//
//  Created by Danniel on 12/07/26.
//

import SwiftUI

struct Contact: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let phone: String
    let tint: Color

    var initials: String {
        let parts = name.split(separator: " ")
        guard let first = parts.first?.first else { return "?" }
        if parts.count >= 2, let second = parts[1].first {
            return "\(first.uppercased())\(second.lowercased())"
        }
        return first.uppercased()
    }

    static let sample: [Contact] = [
        Contact(name: "Aldi bengkel", phone: "089567896712", tint: .yellow),
        Contact(name: "Ahmad", phone: "089567896712", tint: .blue),
        Contact(name: "Budi Jus", phone: "089567896712", tint: .orange),
        Contact(name: "Burhan galon", phone: "089567896712", tint: .purple),
        Contact(name: "Charles Bangunan", phone: "089567896712", tint: .teal),
        Contact(name: "Dewi Warung", phone: "089567896712", tint: .indigo),
        Contact(name: "Eko Sayur", phone: "089567896712", tint: .green),
        Contact(name: "Garhan", phone: "089567896712", tint: .red),
        Contact(name: "Vanessa", phone: "089567896712", tint: .mint),
    ]
}

private struct ContactAvatar: View {
    let contact: Contact
    var size: CGFloat = 44

    var body: some View {
        Text(contact.initials)
            .font(size > 48 ? .title3.bold() : .headline)
            .foregroundStyle(.white)
            .frame(width: size, height: size)
            .background(contact.tint, in: Circle())
    }
}

struct PostRecipientSheet: View {
    var onDone: () -> Void = {}

    @Environment(\.dismiss) private var dismiss

    @State private var query: String = ""
    @State private var selected: Set<UUID> = Set(Contact.sample.prefix(4).map(\.id))

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if !selectedContacts.isEmpty {
                    selectedStrip
                    Divider()
                }

                contactListHeader

                Divider()

                contactList
            }
            .background(Color.white)
            .navigationTitle("Posting ke siapa saja?")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { closeButton }
                ToolbarItem(placement: .topBarTrailing) { doneButton }
            }
            
        }
    }

    // MARK: - Toolbar buttons

    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark")
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.primary)
                
        }
        .accessibilityLabel("Tutup")
    }

    private var doneButton: some View {
        Button {
            dismiss()
            onDone()
        } label: {
            Image(systemName: "checkmark")
                .font(.system(size: 15, weight: .bold))
                .foregroundStyle(.white)
        }
        .buttonStyle(.borderedProminent)
        .tint(Color.accents)
        .buttonBorderShape(.circle)
        .accessibilityLabel("Selesai")
    }

    // MARK: - Selected strip

    private var selectedStrip: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 18) {
                ForEach(selectedContacts) { contact in
                    VStack(spacing: 6) {
                        ContactAvatar(contact: contact, size: 56)
                            .overlay(alignment: .bottomTrailing) {
                                Image("iMessage")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 20, height: 20)
                            }

                        Text(contact.name)
                            .font(.caption)
                            .foregroundStyle(.primary)
                            .lineLimit(2)
                            .multilineTextAlignment(.center)
                            .frame(width: 64)
                    }
                }
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 10)
        }
    }

    // MARK: - Header: title + search

    private var contactListHeader: some View {
        HStack(spacing: 12) {
            Text("Daftar Kontak")
                .font(.title3.bold())

            Spacer()

            HStack(spacing: 6) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(.secondary)
                TextField("Cari nama", text: $query)
                    .autocorrectionDisabled()
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color(.systemGray6), in: Capsule())
            .frame(maxWidth: 190)
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 10)
    }

    // MARK: - Contact list

    private var contactList: some View {
        List {
            Section {
                Button {
                    toggleSelectAll()
                } label: {
                    HStack {
                        Text("Pilih Semua Kontak")
                            .foregroundStyle(.primary)
                        Spacer()
                        Image(systemName: allSelected ? "checkmark.square.fill" : "square")
                            .font(.title3)
                            .foregroundStyle(allSelected ? Color.accents : Color(.systemGray3))
                    }
                    .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
            }

            ForEach(grouped, id: \.0) { letter, contacts in
                Section(letter) {
                    ForEach(contacts) { contact in
                        contactRow(contact)
                    }
                }
            }
        }
        .listStyle(.plain)
    }

    private func contactRow(_ contact: Contact) -> some View {
        Button {
            toggle(contact)
        } label: {
            HStack(spacing: 12) {
                ContactAvatar(contact: contact, size: 44)

                VStack(alignment: .leading, spacing: 2) {
                    Text(contact.name)
                        .font(.body.weight(.medium))
                        .foregroundStyle(.primary)
                    Text(contact.phone)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: selected.contains(contact.id) ? "largecircle.fill.circle" : "circle")
                    .font(.title3)
                    .foregroundStyle(selected.contains(contact.id) ? Color.accents : Color(.systemGray3))
            }
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }

    // MARK: - Derived data

    private var selectedContacts: [Contact] {
        Contact.sample.filter { selected.contains($0.id) }
    }

    private var filtered: [Contact] {
        guard !query.isEmpty else { return Contact.sample }
        return Contact.sample.filter { $0.name.localizedCaseInsensitiveContains(query) }
    }

    private var grouped: [(String, [Contact])] {
        Dictionary(grouping: filtered) { String($0.name.prefix(1)).uppercased() }
            .map { ($0.key, $0.value.sorted { $0.name < $1.name }) }
            .sorted { $0.0 < $1.0 }
    }

    private var allSelected: Bool {
        !Contact.sample.isEmpty && selected.count == Contact.sample.count
    }

    // MARK: - Actions

    private func toggle(_ contact: Contact) {
        if selected.contains(contact.id) {
            selected.remove(contact.id)
        } else {
            selected.insert(contact.id)
        }
    }

    private func toggleSelectAll() {
        if allSelected {
            selected.removeAll()
        } else {
            selected = Set(Contact.sample.map(\.id))
        }
    }
}

#Preview {
    PostRecipientSheet()
}
